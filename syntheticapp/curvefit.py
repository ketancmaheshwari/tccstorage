import pdb
import sys
import numpy as np
from scipy.optimize import curve_fit

""" 
#Example
def func(x, a, b, c):
    return a*np.exp(-b*x) + c

x = np.linspace(0,4,50)
y = func(x, 2.5, 1.3, 0.5)
yn = y + 0.2*np.random.normal(size=len(x))
popt, pcov = curve_fit(func, x, yn)

pdb.set_trace()
def func(x, a, c):
    return a*x + c

#x = np.linspace(0,4,50)
x = np.array([1, 2, 4, 8, 16])
yn = func(x, 2.5, 0.5)
popt, pcov = curve_fit(func, x, yn)
"""

def func(x, a, b, c):
    return a * x * x + b * x + c

def parseMeasure(filename):
    fp = open(filename)
    fitting = {}
    start = False
    for line in fp:
        if line.startswith('process'):
            start = True
        elif start:
            if '|' in line:
                items = line.split('|')
                items = [i.strip() for i in items]
                popt, pcov = curveFitting(items[1:])
                fitting[items[0]] = popt
    return fitting

def curveFitting(items):
    num_cores = np.array([2**i for i in range(len(items))])
    y = np.array([float(i) for i in items])
    popt, pcov = curve_fit(func, num_cores, y)
    return popt, pcov

# generate coefficients for all apps on all systems
sites = ['blues','midway','stampede', 'trestles']
coeffs = {}
for site in sites:
    filename = 'results.%s.txt' % site
    fitting = parseMeasure(filename)
    for app, coef in fitting.iteritems():
      if app not in coeffs: coeffs[app] = {}
      coeffs[app][site] = coef

ret = []

for app, fitting in coeffs.iteritems():
    ret.append('----- %s -----' % app)
    ret.append('switch(system)')
    ret.append('{')
    for site, coeff in fitting.iteritems():
        ret.append('  case(%s)' % site)
        ret.append('  {')
        ret.append('    comp %f * nodes * nodes + %f * nodes + %f'%(coeff[0], coeff[1], coeff[2]))
        ret.append('  }')
        ret.append('  break')
    ret.append('}')

print '\n'.join(ret)

