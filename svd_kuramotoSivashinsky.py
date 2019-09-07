
# coding: utf-8

# In[1]:

import numpy as np
import numpy.linalg as la
import matplotlib.pyplot as plt
import pandas as pd


# In[5]:

ks=pd.read_csv('kstable.csv', sep=',',header=[0]) #Soultion to the Kuramoto-Sivashinsky equation


# In[10]:

plt.imshow(ks, cmap='Set1', interpolation='none') #cmap: magma, inferno, Pastel1...
                                                  #https://matplotlib.org/examples/color/colormaps_reference.html
plt.show()


# In[11]:

U, sigma, V = np.linalg.svd(ks);


# In[13]:

reconstimg = np.matrix(U[:, :1]) * np.diag(sigma[:1]) * np.matrix(V[:1, :])
plt.imshow(reconstimg, cmap='Set1', interpolation='none');
plt.show()


# In[26]:

#Even with just the second and third vectors, the shape of the stiffness mtx begins to appear.
nmax=3;
for i in range(1,nmax):
    reconstimg = np.matrix(U[:, :i]) * np.diag(sigma[:i]) * np.matrix(V[:i, :])
    plt.imshow(reconstimg, cmap='Set1', interpolation='none')
    title = "n = %s" % i
    plt.title(title)
    plt.show()


# In[62]:

fig=plt.figure()
fig.subplots_adjust(wspace=2, hspace=0.6)

plt.subplot(2,2,1)
plt.imshow(np.matrix(U[:, :1]) * np.diag(sigma[:1]) * np.matrix(V[:1, :]), cmap='Set1', interpolation='none')
plt.title('n=1, \ncompressed representation')
plt.subplot(2,2,2)
plt.imshow(np.matrix(U[:, :2]) * np.diag(sigma[:2]) * np.matrix(V[:2, :]), cmap='Set1', interpolation='none')
plt.title('n=2')
plt.subplot(2,2,3)
plt.imshow(np.matrix(U[:, :3]) * np.diag(sigma[:3]) * np.matrix(V[:3, :]), cmap='Set1', interpolation='none')
plt.title('n=3')
plt.subplot(2,2,4)
plt.imshow(ks, cmap='Set1', interpolation='none')
plt.title('full representation')
plt.grid(True)
fig.suptitle('Singular Value Decomposition of Kuramoto-Sivashinsky chaotic PDE', size=14, y=1.08) # or plt.suptitle('Main title')
plt.show()
fig.savefig("ks_SVD.pdf", bbox_inches='tight')
fig.savefig("ks_SVD.png", bbox_inches='tight')


# In[ ]:



