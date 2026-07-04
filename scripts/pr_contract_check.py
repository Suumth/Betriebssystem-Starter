#!/usr/bin/env python3
import json, os, re, sys
REQ=['Validation Evidence','Review of Record','Human Gate','Operator Summary','Review Recommendation']
EMPTY={'-','- status: pending','- reviewer:','- link:','- required: yes/no','- reason:','required: yes/no'}
BAD_AUTO=['needs-human','needs-fix','blocked','risk:protected','risk:release']

def sections(body):
    body=body or ''
    out={}
    hits=list(re.finditer(r'^## ([^\n]+)\s*$', body, re.M))
    for i,m in enumerate(hits):
        end=hits[i+1].start() if i+1 < len(hits) else len(body)
        out[m.group(1).strip()]=body[m.end():end]
    return out

def filled(text):
    for raw in text.splitlines():
        line=raw.strip()
        if line and line.lower() not in EMPTY and not (line.startswith('- ') and not line[2:].strip()):
            return True
    return False

def human_gate(text, value):
    return re.search(r'Required:\s*'+value+r'\b', sections(text).get('Human Gate',''), re.I) is not None

def check(body, labels):
    labels=set(labels)
    out=[]
    sec=sections(body)
    for name in REQ:
        if name not in sec: out.append('missing section: ## '+name)
        elif not filled(sec[name]): out.append('empty section: ## '+name)
    if 'Human Gate' in sec and not (human_gate(body,'yes') or human_gate(body,'no')):
        out.append('Human Gate must say Required: yes or Required: no')
    if 'auto-merge:ok' in labels and 'review:pass' not in labels:
        out.append('auto-merge:ok requires review:pass')
    if 'auto-merge:ok' in labels:
        for label in BAD_AUTO:
            if label in labels: out.append('auto-merge:ok conflicts with '+label)
    if 'review:pass' in labels and 'needs-fix' in labels:
        out.append('review:pass conflicts with needs-fix')
    if 'auto-merge:ok' in labels and human_gate(body,'yes'):
        out.append('auto-merge:ok conflicts with Human Gate Required: yes')
    return out

def main():
    path=os.environ.get('GITHUB_EVENT_PATH')
    if not path:
        print('FAIL: event path is not set'); return 1
    event=json.load(open(path,encoding='utf-8'))
    pr=event.get('pull_request',{})
    failures=check(pr.get('body') or '', [x.get('name','') for x in pr.get('labels',[])])
    if failures:
        for item in failures: print('FAIL: '+item)
        return 1
    print('PASS: PR contract is satisfied')
    return 0
if __name__=='__main__': sys.exit(main())
