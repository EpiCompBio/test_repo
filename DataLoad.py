# -*- coding: utf-8 -*-
"""
Created on Thu Sep 29 15:52:51 2016

@author: Deborah
"""
from scipy.io import loadmat
import numpy as np

def load_Clinical():
## Load Clinical data 
    path = 'D:\COMBI_BIO\CLINICAL\CLINICAL_VARINFO.txt'
    CLI_var_names = np.genfromtxt(path,dtype='str')
    CLI_var_names = list(CLI_var_names)
    path = 'D:\COMBI_BIO\CLINICAL\Matched_CLI_Data_CPMG.mat'
    var_all = loadmat(path)
    CLI_var_all = var_all['Matched_CLI_Data']
    return CLI_var_all,CLI_var_names
    
def load_NMR():
    path = r'D:\COMBI_BIO\CPMG\NMR_CPMG_MESA.mat'
    NMRs = loadmat(path)
    NMR_P1 = NMRs['NMR_CPMG_M_P1']
    #NMR_P2 = NMRs['NMR_CPMG_M_P2']
    del NMRs
    #Load ppm hits
    path = r'D:\COMBI_BIO\NOESY\NMR_NOESY_ppm.mat'
    ppms = loadmat(path)
    ppm = ppms['ppm']
    ppm = np.squeeze(ppm)
    del ppms
    return NMR_P1,ppm
    
def load_Cli_Info():
    path = 'D:\COMBI_BIO\CLINICAL\CLINICAL_SAMPLEINFO.txt'
    Sample_Info = np.genfromtxt(path,dtype='str')
    cohort = Sample_Info[1::,1]
    phase = Sample_Info[1::,2]
    return cohort,phase
    