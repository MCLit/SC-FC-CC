% create short network representation of Shen's parcellation based on max
% overlap (direction = what 7 rsn occupies most of Shen's parcel)
clear
shen = {'shen_278_rois_2mm_N1.nii'
'shen_278_rois_2mm_N2.nii'
'shen_278_rois_2mm_N3.nii'
'shen_278_rois_2mm_N4.nii'
'shen_278_rois_2mm_N5.nii'
'shen_278_rois_2mm_N6.nii'
'shen_278_rois_2mm_N7.nii'
'shen_278_rois_2mm_N8.nii'
'shen_278_rois_2mm_N9.nii'
'shen_278_rois_2mm_N10.nii'
'shen_278_rois_2mm_N11.nii'
'shen_278_rois_2mm_N12.nii'
'shen_278_rois_2mm_N13.nii'
'shen_278_rois_2mm_N14.nii'
'shen_278_rois_2mm_N15.nii'
'shen_278_rois_2mm_N16.nii'
'shen_278_rois_2mm_N17.nii'
'shen_278_rois_2mm_N18.nii'
'shen_278_rois_2mm_N19.nii'
'shen_278_rois_2mm_N20.nii'
'shen_278_rois_2mm_N21.nii'
'shen_278_rois_2mm_N22.nii'
'shen_278_rois_2mm_N23.nii'
'shen_278_rois_2mm_N24.nii'
'shen_278_rois_2mm_N25.nii'
'shen_278_rois_2mm_N26.nii'
'shen_278_rois_2mm_N27.nii'
'shen_278_rois_2mm_N28.nii'
'shen_278_rois_2mm_N29.nii'
'shen_278_rois_2mm_N30.nii'
'shen_278_rois_2mm_N31.nii'
'shen_278_rois_2mm_N32.nii'
'shen_278_rois_2mm_N33.nii'
'shen_278_rois_2mm_N34.nii'
'shen_278_rois_2mm_N35.nii'
'shen_278_rois_2mm_N36.nii'
'shen_278_rois_2mm_N37.nii'
'shen_278_rois_2mm_N38.nii'
'shen_278_rois_2mm_N39.nii'
'shen_278_rois_2mm_N40.nii'
'shen_278_rois_2mm_N41.nii'
'shen_278_rois_2mm_N42.nii'
'shen_278_rois_2mm_N43.nii'
'shen_278_rois_2mm_N44.nii'
'shen_278_rois_2mm_N45.nii'
'shen_278_rois_2mm_N46.nii'
'shen_278_rois_2mm_N47.nii'
'shen_278_rois_2mm_N48.nii'
'shen_278_rois_2mm_N49.nii'
'shen_278_rois_2mm_N50.nii'
'shen_278_rois_2mm_N51.nii'
'shen_278_rois_2mm_N52.nii'
'shen_278_rois_2mm_N53.nii'
'shen_278_rois_2mm_N54.nii'
'shen_278_rois_2mm_N55.nii'
'shen_278_rois_2mm_N56.nii'
'shen_278_rois_2mm_N57.nii'
'shen_278_rois_2mm_N58.nii'
'shen_278_rois_2mm_N59.nii'
'shen_278_rois_2mm_N60.nii'
'shen_278_rois_2mm_N61.nii'
'shen_278_rois_2mm_N62.nii'
'shen_278_rois_2mm_N63.nii'
'shen_278_rois_2mm_N64.nii'
'shen_278_rois_2mm_N65.nii'
'shen_278_rois_2mm_N66.nii'
'shen_278_rois_2mm_N67.nii'
'shen_278_rois_2mm_N68.nii'
'shen_278_rois_2mm_N69.nii'
'shen_278_rois_2mm_N70.nii'
'shen_278_rois_2mm_N71.nii'
'shen_278_rois_2mm_N72.nii'
'shen_278_rois_2mm_N73.nii'
'shen_278_rois_2mm_N74.nii'
'shen_278_rois_2mm_N75.nii'
'shen_278_rois_2mm_N76.nii'
'shen_278_rois_2mm_N77.nii'
'shen_278_rois_2mm_N78.nii'
'shen_278_rois_2mm_N79.nii'
'shen_278_rois_2mm_N80.nii'
'shen_278_rois_2mm_N81.nii'
'shen_278_rois_2mm_N82.nii'
'shen_278_rois_2mm_N83.nii'
'shen_278_rois_2mm_N84.nii'
'shen_278_rois_2mm_N85.nii'
'shen_278_rois_2mm_N86.nii'
'shen_278_rois_2mm_N87.nii'
'shen_278_rois_2mm_N88.nii'
'shen_278_rois_2mm_N89.nii'
'shen_278_rois_2mm_N90.nii'
'shen_278_rois_2mm_N91.nii'
'shen_278_rois_2mm_N92.nii'
'shen_278_rois_2mm_N93.nii'
'shen_278_rois_2mm_N94.nii'
'shen_278_rois_2mm_N95.nii'
'shen_278_rois_2mm_N96.nii'
'shen_278_rois_2mm_N97.nii'
'shen_278_rois_2mm_N98.nii'
'shen_278_rois_2mm_N99.nii'
'shen_278_rois_2mm_N100.nii'
'shen_278_rois_2mm_N101.nii'
'shen_278_rois_2mm_N102.nii'
'shen_278_rois_2mm_N103.nii'
'shen_278_rois_2mm_N104.nii'
'shen_278_rois_2mm_N105.nii'
'shen_278_rois_2mm_N106.nii'
'shen_278_rois_2mm_N107.nii'
'shen_278_rois_2mm_N108.nii'
'shen_278_rois_2mm_N109.nii'
'shen_278_rois_2mm_N110.nii'
'shen_278_rois_2mm_N111.nii'
'shen_278_rois_2mm_N112.nii'
'shen_278_rois_2mm_N113.nii'
'shen_278_rois_2mm_N114.nii'
'shen_278_rois_2mm_N115.nii'
'shen_278_rois_2mm_N116.nii'
'shen_278_rois_2mm_N117.nii'
'shen_278_rois_2mm_N118.nii'
'shen_278_rois_2mm_N119.nii'
'shen_278_rois_2mm_N120.nii'
'shen_278_rois_2mm_N121.nii'
'shen_278_rois_2mm_N122.nii'
'shen_278_rois_2mm_N123.nii'
'shen_278_rois_2mm_N124.nii'
'shen_278_rois_2mm_N125.nii'
'shen_278_rois_2mm_N126.nii'
'shen_278_rois_2mm_N127.nii'
'shen_278_rois_2mm_N128.nii'
'shen_278_rois_2mm_N129.nii'
'shen_278_rois_2mm_N130.nii'
'shen_278_rois_2mm_N131.nii'
'shen_278_rois_2mm_N132.nii'
'shen_278_rois_2mm_N133.nii'
'shen_278_rois_2mm_N134.nii'
'shen_278_rois_2mm_N135.nii'
'shen_278_rois_2mm_N136.nii'
'shen_278_rois_2mm_N137.nii'
'shen_278_rois_2mm_N138.nii'
'shen_278_rois_2mm_N139.nii'
'shen_278_rois_2mm_N140.nii'
'shen_278_rois_2mm_N141.nii'
'shen_278_rois_2mm_N142.nii'
'shen_278_rois_2mm_N143.nii'
'shen_278_rois_2mm_N144.nii'
'shen_278_rois_2mm_N145.nii'
'shen_278_rois_2mm_N146.nii'
'shen_278_rois_2mm_N147.nii'
'shen_278_rois_2mm_N148.nii'
'shen_278_rois_2mm_N149.nii'
'shen_278_rois_2mm_N150.nii'
'shen_278_rois_2mm_N151.nii'
'shen_278_rois_2mm_N152.nii'
'shen_278_rois_2mm_N153.nii'
'shen_278_rois_2mm_N154.nii'
'shen_278_rois_2mm_N155.nii'
'shen_278_rois_2mm_N156.nii'
'shen_278_rois_2mm_N157.nii'
'shen_278_rois_2mm_N158.nii'
'shen_278_rois_2mm_N159.nii'
'shen_278_rois_2mm_N160.nii'
'shen_278_rois_2mm_N161.nii'
'shen_278_rois_2mm_N162.nii'
'shen_278_rois_2mm_N163.nii'
'shen_278_rois_2mm_N164.nii'
'shen_278_rois_2mm_N165.nii'
'shen_278_rois_2mm_N166.nii'
'shen_278_rois_2mm_N167.nii'
'shen_278_rois_2mm_N168.nii'
'shen_278_rois_2mm_N169.nii'
'shen_278_rois_2mm_N170.nii'
'shen_278_rois_2mm_N171.nii'
'shen_278_rois_2mm_N172.nii'
'shen_278_rois_2mm_N173.nii'
'shen_278_rois_2mm_N174.nii'
'shen_278_rois_2mm_N175.nii'
'shen_278_rois_2mm_N176.nii'
'shen_278_rois_2mm_N177.nii'
'shen_278_rois_2mm_N178.nii'
'shen_278_rois_2mm_N179.nii'
'shen_278_rois_2mm_N180.nii'
'shen_278_rois_2mm_N181.nii'
'shen_278_rois_2mm_N182.nii'
'shen_278_rois_2mm_N183.nii'
'shen_278_rois_2mm_N184.nii'
'shen_278_rois_2mm_N185.nii'
'shen_278_rois_2mm_N186.nii'
'shen_278_rois_2mm_N187.nii'
'shen_278_rois_2mm_N188.nii'
'shen_278_rois_2mm_N189.nii'
'shen_278_rois_2mm_N190.nii'
'shen_278_rois_2mm_N191.nii'
'shen_278_rois_2mm_N192.nii'
'shen_278_rois_2mm_N193.nii'
'shen_278_rois_2mm_N194.nii'
'shen_278_rois_2mm_N195.nii'
'shen_278_rois_2mm_N196.nii'
'shen_278_rois_2mm_N197.nii'
'shen_278_rois_2mm_N198.nii'
'shen_278_rois_2mm_N199.nii'
'shen_278_rois_2mm_N200.nii'
'shen_278_rois_2mm_N201.nii'
'shen_278_rois_2mm_N202.nii'
'shen_278_rois_2mm_N203.nii'
'shen_278_rois_2mm_N204.nii'
'shen_278_rois_2mm_N205.nii'
'shen_278_rois_2mm_N206.nii'
'shen_278_rois_2mm_N207.nii'
'shen_278_rois_2mm_N208.nii'
'shen_278_rois_2mm_N209.nii'
'shen_278_rois_2mm_N210.nii'
'shen_278_rois_2mm_N211.nii'
'shen_278_rois_2mm_N212.nii'
'shen_278_rois_2mm_N213.nii'
'shen_278_rois_2mm_N214.nii'
'shen_278_rois_2mm_N215.nii'
'shen_278_rois_2mm_N216.nii'
'shen_278_rois_2mm_N217.nii'
'shen_278_rois_2mm_N218.nii'
'shen_278_rois_2mm_N219.nii'
'shen_278_rois_2mm_N220.nii'
'shen_278_rois_2mm_N221.nii'
'shen_278_rois_2mm_N222.nii'
'shen_278_rois_2mm_N223.nii'
'shen_278_rois_2mm_N224.nii'
'shen_278_rois_2mm_N225.nii'
'shen_278_rois_2mm_N226.nii'
'shen_278_rois_2mm_N227.nii'
'shen_278_rois_2mm_N228.nii'
'shen_278_rois_2mm_N229.nii'
'shen_278_rois_2mm_N230.nii'
'shen_278_rois_2mm_N231.nii'
'shen_278_rois_2mm_N232.nii'
'shen_278_rois_2mm_N233.nii'
'shen_278_rois_2mm_N234.nii'
'shen_278_rois_2mm_N235.nii'
'shen_278_rois_2mm_N236.nii'
'shen_278_rois_2mm_N237.nii'
'shen_278_rois_2mm_N238.nii'
'shen_278_rois_2mm_N239.nii'
'shen_278_rois_2mm_N240.nii'
'shen_278_rois_2mm_N241.nii'
'shen_278_rois_2mm_N242.nii'
'shen_278_rois_2mm_N243.nii'
'shen_278_rois_2mm_N244.nii'
'shen_278_rois_2mm_N245.nii'
'shen_278_rois_2mm_N246.nii'
'shen_278_rois_2mm_N247.nii'
'shen_278_rois_2mm_N248.nii'
'shen_278_rois_2mm_N249.nii'
'shen_278_rois_2mm_N250.nii'
'shen_278_rois_2mm_N251.nii'
'shen_278_rois_2mm_N252.nii'
'shen_278_rois_2mm_N253.nii'
'shen_278_rois_2mm_N254.nii'
'shen_278_rois_2mm_N255.nii'
'shen_278_rois_2mm_N256.nii'
'shen_278_rois_2mm_N257.nii'
'shen_278_rois_2mm_N258.nii'
'shen_278_rois_2mm_N259.nii'
'shen_278_rois_2mm_N260.nii'
'shen_278_rois_2mm_N261.nii'
'shen_278_rois_2mm_N262.nii'
'shen_278_rois_2mm_N263.nii'
'shen_278_rois_2mm_N264.nii'
'shen_278_rois_2mm_N265.nii'
'shen_278_rois_2mm_N266.nii'
'shen_278_rois_2mm_N267.nii'
'shen_278_rois_2mm_N268.nii'
'shen_278_rois_2mm_N269.nii'
'shen_278_rois_2mm_N270.nii'
'shen_278_rois_2mm_N271.nii'
'shen_278_rois_2mm_N272.nii'
'shen_278_rois_2mm_N273.nii'
'shen_278_rois_2mm_N274.nii'
'shen_278_rois_2mm_N275.nii'
'shen_278_rois_2mm_N276.nii'
'shen_278_rois_2mm_N277.nii'
'shen_278_rois_2mm_N278.nii'};

shen_region = (shen);

% comparison parcels

AAL_3_rois = {'Yeo7_rois_1.nii'
'Yeo7_rois_2.nii'
'Yeo7_rois_3.nii'
'Yeo7_rois_4.nii'
'Yeo7_rois_5.nii'
'Yeo7_rois_6.nii'
'Yeo7_rois_7.nii'
'Yeo7_rois_8.nii'
'Yeo7_rois_9.nii'
'Yeo7_rois_10.nii'
'Yeo7_rois_11.nii'
'Yeo7_rois_12.nii'
'Yeo7_rois_13.nii'
'Yeo7_rois_14.nii'
'Yeo7_rois_15.nii'
'Yeo7_rois_16.nii'
'Yeo7_rois_17.nii'
'Yeo7_rois_18.nii'
'Yeo7_rois_19.nii'
'Yeo7_rois_20.nii'
'Yeo7_rois_21.nii'
'Yeo7_rois_22.nii'
'Yeo7_rois_23.nii'
'Yeo7_rois_24.nii'
'Yeo7_rois_25.nii'
'Yeo7_rois_26.nii'
'Yeo7_rois_27.nii'
'Yeo7_rois_28.nii'
'Yeo7_rois_29.nii'
'Yeo7_rois_30.nii'
'Yeo7_rois_31.nii'
'Yeo7_rois_32.nii'
'Yeo7_rois_33.nii'
'Yeo7_rois_34.nii'
'Yeo7_rois_35.nii'
'Yeo7_rois_36.nii'
'Yeo7_rois_37.nii'
'Yeo7_rois_38.nii'
'Yeo7_rois_39.nii'
'Yeo7_rois_40.nii'
'Yeo7_rois_41.nii'
'Yeo7_rois_42.nii'
'Yeo7_rois_43.nii'
'Yeo7_rois_44.nii'
'Yeo7_rois_45.nii'
'Yeo7_rois_46.nii'
'Yeo7_rois_47.nii'
'Yeo7_rois_48.nii'
'Yeo7_rois_49.nii'
'Yeo7_rois_50.nii'
'Yeo7_rois_51.nii'};

AAL_region_code = (AAL_3_rois);

abbreviations = {"visual"
"somatomotor"
"dorsatt"
"dorsatt"
"dorsatt"
"salva"
"salva"
"salva"
"salva"
"salva"
"limbic"
"limbic"
"control"
"control"
"control"
"control"
"control"
"control"
"control"
"control"
"control"
"default"
"default"
"default"
"default"
"default"
"visual"
"somatomotor"
"dorsatt"
"dorsatt"
"dorsatt"
"salva"
"salva"
"salva"
"salva"
"salva"
"salva"
"limbic"
"limbic"
"control"
"control"
"control"
"control"
"control"
"control"
"control"
"default"
"default"
"default"
"default"
"default"};



rsn_17_regions = {"striate cortex"
"extrastriate cortex"
"striate calcarine"
"extra-striate inferior"
"extra-striate superior"
"somatomotor A"
"central"
"S2"
"insula"
"auditory"
"temporal occipital"
"parietal occipital"
"superior parietal lobule"
"temporal occipital"
"post central"
"frontal eye fields"
"precentral ventral"
"parietal operculum"
"frontal operculum"
"insula"
"parietal medial"
"frontal medial"
"inferior parietal lobule"
"dorsal prefrontal cortex"
"lateral prefrontal cortex"
"insula"
"orbital frontal cortex"
"medial posterior prefrontal cortex"
"temporal pole"
"orbital frontal cortex"
"temporal"
"intraparietal sulcus"
"dorsal prefrontal cortex"
"lateral prefrontal cortex"
"lateral ventral prefrontal cortex"
"mid-cingulate"
"temporal"
"inferior parietal lobule"
"dorsal prefrontal cortex"
"lateral prefrontal cortex"
"lateral ventral prefrontal cortex"
"medial posterior prefrontal cortex"
"precuneus"
"cingulate posterior"
"inferior parietal lobule"
"dorsal prefrontal cortex"
"precuneus posterior cingulate cortex"
"medial prefrontal cortex"
"temporal"
"inferior parietal lobule"
"dorsal prefrontal cortex"
"lateral prefrontal cortex"
"ventral prefrontal cortex"
"inferior parietal lobule"
"retrosplenial"
"parahippocampal cortex"
"temporal parietal"
"striate cortex"
"extrastriate cortex"
"striate calcarine"
"extra-striate inferior"
"extra-striate superior"
"somatomotor A"
"central"
"S2"
"insula"
"auditory"
"temporal occipital"
"parietal occipital"
"superior parietal lobule"
"temporal occipital"
"post central"
"frontal eye fields"
"precentral ventral"
"parietal operculum"
"precentral"
"frontal operculum"
"insula"
"parietal medial"
"frontal medial"
"inferior parietal lobule"
"dorsal prefrontal cortex"
"lateral prefrontal cortex"
"lateral ventral prefrontal cortex"
"insula"
"medial posterior prefrontal cortex"
"cingulate anterior"
"temporal pole"
"orbital frontal cortex"
"temporal"
"intraparietal sulcus"
"dorsal prefrontal cortex"
"lateral prefrontal cortex"
"mid-cingulate"
"temporal"
"inferior parietal lobule"
"lateral dorsal prefrontal cortex"
"lateral ventral prefrontal cortex"
"medial posterior prefrontal cortex"
"precuneus"
"cingulate posterior"
"temporal"
"inferior parietal lobule"
"dorsal prefrontal cortex"
"precuneus posterior cingulate cortex"
"medial prefrontal cortex"
"temporal"
"anterior temporal"
"dorsal prefrontal cortex"
"ventral prefrontal cortex"
"inferior parietal lobule"
"retrosplenial"
"parahippocampal cortex"
"temporal parietal"};

H_17rsn_regions = {"(LH) striate cortex"
"(LH) extrastriate cortex"
"(LH) striate calcarine"
"(LH) extra-striate inferior"
"(LH) extra-striate superior"
"(LH) somatomotor A"
"(LH) central"
"(LH) S2"
"(LH) insula 1"
"(LH) auditory"
"(LH) temporal occipital 1"
"(LH) parietal occipital"
"(LH) superior parietal lobule"
"(LH) temporal occipital 2"
"(LH) post central"
"(LH) frontal eye fields"
"(LH) precentral ventral"
"(LH) parietal operculum"
"(LH) frontal operculum"
"(LH) insula 2"
"(LH) parietal medial"
"(LH) frontal medial"
"(LH) inferior parietal lobule 1"
"(LH) dorsal prefrontal cortex 1"
"(LH) lateral prefrontal cortex 1"
"(LH) insula 3"
"(LH) orbital frontal cortex 1"
"(LH) medial posterior prefrontal cortex 1"
"(LH) temporal pole"
"(LH) orbital frontal cortex 2"
"(LH) temporal 1"
"(LH) intraparietal sulcus"
"(LH) dorsal prefrontal cortex 2"
"(LH) lateral prefrontal cortex 2"
"(LH) lateral ventral prefrontal cortex 1"
"(LH) mid-cingulate"
"(LH) temporal 2"
"(LH) inferior parietal lobule 2"
"(LH) dorsal prefrontal cortex 3"
"(LH) lateral prefrontal cortex 3"
"(LH) lateral ventral prefrontal cortex 2"
"(LH) medial posterior prefrontal cortex 2"
"(LH) precuneus"
"(LH) cingulate posterior"
"(LH) inferior parietal lobule 3"
"(LH) dorsal prefrontal cortex 4"
"(LH) precuneus posterior cingulate cortex"
"(LH) medial prefrontal cortex"
"(LH) temporal 3"
"(LH) inferior parietal lobule 4"
"(LH) dorsal prefrontal cortex 5"
"(LH) lateral prefrontal cortex 4"
"(LH) ventral prefrontal cortex"
"(LH) inferior parietal lobule 5"
"(LH) retrosplenial"
"(LH) parahippocampal cortex"
"(LH) temporal parietal"
"(RH) striate cortex"
"(RH) extrastriate cortex"
"(RH) striate calcarine"
"(RH) extra-striate inferior"
"(RH) extra-striate superior"
"(RH) somatomotor A"
"(RH) central"
"(RH) S2"
"(RH) insula 1"
"(RH) auditory"
"(RH) temporal occipital 1"
"(RH) parietal occipital"
"(RH) superior parietal lobule"
"(RH) temporal occipital 2"
"(RH) post central"
"(RH) frontal eye fields"
"(RH) precentral ventral"
"(RH) parietal operculum"
"(RH) precentral"
"(RH) frontal operculum"
"(RH) insula 2"
"(RH) parietal medial"
"(RH) frontal medial"
"(RH) inferior parietal lobule 1"
"(RH) dorsal prefrontal cortex 1"
"(RH) lateral prefrontal cortex 1"
"(RH) lateral ventral prefrontal cortex 1"
"(RH) insula 3"
"(RH) medial posterior prefrontal cortex 1"
"(RH) cingulate anterior"
"(RH) temporal pole"
"(RH) orbital frontal cortex"
"(RH) temporal 1"
"(RH) intraparietal sulcus"
"(RH) dorsal prefrontal cortex 2"
"(RH) lateral prefrontal cortex 2"
"(RH) mid-cingulate"
"(RH) temporal 2"
"(RH) inferior parietal lobule 2"
"(RH) lateral dorsal prefrontal cortex"
"(RH) lateral ventral prefrontal cortex 2"
"(RH) medial posterior prefrontal cortex 2"
"(RH) precuneus"
"(RH) cingulate posterior"
"(RH) temporal 3"
"(RH) inferior parietal lobule 3"
"(RH) dorsal prefrontal cortex 3"
"(RH) precuneus posterior cingulate cortex"
"(RH) medial prefrontal cortex"
"(RH) temporal 4"
"(RH) anterior temporal"
"(RH) dorsal prefrontal cortex 4"
"(RH) ventral prefrontal cortex"
"(RH) inferior parietal lobule 4"
"(RH) retrosplenial"
"(RH) parahippocampal cortex"
"(RH) temporal parietal"};

short_17_networks = {};
%%
new_labels = abbreviations; % what do you want to save? abbreviations of subnetwork, regions, H regions
out = cell(278, 1); % output of this script
for j = 1:278
    
    % load the shen region whose label we are looking for
    present_shen_region = shen_region(j,1);
    present_shen_region = ['/Users/user/Dropbox (The University of Manchester)/Year 1/Year 1 Rotation 3/Atlases/shen/300_rois/unpacked/', present_shen_region];
    present_shen_region = join(present_shen_region,'');
    present_shen_region = string(present_shen_region);
    present_shen_region = niftiread(present_shen_region);
    
    
for i = 1:length(AAL_region_code) % for each Shen region find corresponding AAL region|(s) and label(s)

    % move each potential AAL3 region and its label
    present_rsn_region = ['/Users/user/yeo7nets/7/', AAL_region_code(i,1)];
    present_rsn_region = join(present_rsn_region,'');
    present_rsn_region = string(present_rsn_region);
    present_rsn_region = niftiread(present_rsn_region);
    label = new_labels(i,:);
    
    % gets overlap
    ao = sum(present_shen_region & present_rsn_region,'all');
    
    r = sum(present_shen_region, 'all');
    o = ao/r*100;
    o = round(o, 2);
    
    % string out of overlap
    overlap = sprintf('(%.2f %%)',o);
    label = {[label{1,1},overlap]};
%     if o >= 5 %now it will give us only those locations that have 5% overlap or more
        
        
    for x = 1:91
        for y = 1:109
            for z = 1:91
                if present_shen_region(x,y,z) == 1 && present_rsn_region(x,y,z) == 1
                    if isempty(out(j))
                        out(j,:) = label;
%                     elseif isequal(out{j}(:), label{1,1})
                    elseif any(strcmp(out{j}(),label{1,1}{1})) % no duplicates
                        out(j,:) = out(j,:);
                    else % append
                        out(j,:) = strcat(out(j,:), label);
                    end
                end
            end
        end
    end
%     end
end
end

save('labels_7RSN.mat', 'out');
