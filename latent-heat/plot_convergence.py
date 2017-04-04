#!/usr/bin/python

import numpy as np
import matplotlib.pyplot as plt
import colors
from matplotlib.path import Path
import matplotlib.patches as patches

figsize=(7,5)
prop={'size':12}
plt.rc('text', usetex=True)
plt.rcParams['text.latex.preamble'] = '\usepackage{relsize}'
plt.rc('font', family='sanserif')
figure=plt.figure(dpi=100,figsize=figsize) 

# draw a filled area that highlights the 'diagonal' points
verts = [
     (3e2, 6),
     (3e2, 3),
     (6e4, 0.013),
     (6e4, 0.026),
     (3e2, 6),
     ]

codes = [Path.MOVETO,
         Path.LINETO,
         Path.LINETO,
         Path.LINETO,
         Path.CLOSEPOLY,
         ]

fig = plt.figure()
path = Path(verts, codes)
ax = fig.add_subplot(111)
patch = patches.PathPatch(path, facecolor='gainsboro', lw=0)
ax.add_patch(patch)

# ndofs,u,p,p_f,p_c,phi,u_f
file_name=[32000,16000,8000,4000,2000,1000]

data = []
for j in range(0,len(file_name)):
	data = (np.genfromtxt(str(file_name[j]), delimiter=' ', dtype = float))
	plt.loglog(data[:,0],abs(data[:,1]-1111.1111111),color=colors.color(j), marker=colors.marker(j),label='width = '+ str(file_name[j])+' m')

plt.xlim([300, 60000])
#plt.ylim([4e-3,0.4])

plt.xlabel("\#DoFs")
plt.ylabel("Error in K")
 

plt.legend(loc = "upper right", ncol=2, prop=prop)
plt.savefig('latent_heat.pdf', #bbox_extra_artists=(legend,), 
            bbox_inches='tight',dpi=200)

