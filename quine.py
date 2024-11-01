import re
ss="ss2=re.sub('[\\\\\\\\]', '\\\\\\\\\\\\\\\\', ss)\nss2=re.sub('[\\n]', '\\\\\\\\n', ss2)\nss2=re.sub('[\\t]', '\\\\\\\\t', ss2)\nss2=re.sub('[\"]', '\\\\\\\\\"', ss2)\nprint('import re')\nprint('ss=\"%s\"'%ss2)\nprint(ss)"
ss2=re.sub('[\\\\]', '\\\\\\\\', ss)
ss2=re.sub('[\n]', '\\\\n', ss2)
ss2=re.sub('[\t]', '\\\\t', ss2)
ss2=re.sub('["]', '\\\\"', ss2)
print('import re')
print('ss="%s"'%ss2)
print(ss)