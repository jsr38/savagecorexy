float therm_lut[] = { { 0, 1066.26330382 * 8 }, { 0, 651.395048443 * 8 }, { 0, 535.453239241 * 8 }, \ 
  { 0, 473.842436003 * 8 }, { 1, 433.628946334 * 8 }, { 1, 404.485570345 * 8 }, \ 
  { 2, 381.974646367 * 8 }, { 3, 363.823528107 * 8 }, { 4, 348.728216026 * 8 }, \ 
  { 5, 335.878063617 * 8 }, { 6, 324.73810397 * 8 }, { 7, 314.938564659 * 8 }, \ 
  { 9, 306.214225627 * 8 }, { 10, 298.369016419 * 8 }, { 12, 291.254288655 * 8 }, \ 
  { 14, 284.754917991 * 8 }, { 16, 278.780099021 * 8 }, { 18, 273.257064314 * 8 }, \ 
  { 20, 268.126687011 * 8 }, { 23, 263.34033222 * 8 }, { 25, 258.85755751 * 8 }, \ 
  { 28, 254.644403758 * 8 }, { 30, 250.672104694 * 8 }, { 33, 246.916098711 * 8 }, \ 
  { 36, 243.355262416 * 8 }, { 39, 239.971309235 * 8 }, { 43, 236.748312496 * 8 }, \ 
  { 46, 233.67232355 * 8 }, { 49, 230.731063232 * 8 }, { 53, 227.91367054 * 8 }, \ 
  { 57, 225.210496331 * 8 }, { 61, 222.612932783 * 8 }, { 65, 220.113271486 * 8 }, \ 
  { 69, 217.704584621 * 8 }, { 73, 215.380624912 * 8 }, { 77, 213.135740909 * 8 }, \ 
  { 82, 210.964804913 * 8 }, { 86, 208.863151338 * 8 }, { 91, 206.826523782 * 8 }, \ 
  { 96, 204.851029369 * 8 }, { 101, 202.933099218 * 8 }, { 106, 201.069454068 * 8 }, \ 
  { 111, 199.2570743 * 8 }, { 116, 197.493173688 * 8 }, { 122, 195.775176345 * 8 }, \ 
  { 127, 194.100696414 * 8 }, { 133, 192.467520123 * 8 }, { 139, 190.873589879 * 8 }, \ 
  { 145, 189.316990144 * 8 }, { 151, 187.795934844 * 8 }, { 157, 186.308756131 * 8 }, \ 
  { 164, 184.853894321 * 8 }, { 170, 183.429888868 * 8 }, { 177, 182.035370244 * 8 }, \ 
  { 183, 180.669052631 * 8 }, { 190, 179.329727314 * 8 }, { 197, 178.016256711 * 8 }, \ 
  { 204, 176.727568958 * 8 }, { 212, 175.462652997 * 8 }, { 219, 174.220554103 * 8 }, \ 
  { 226, 173.000369813 * 8 }, { 234, 171.80124621 * 8 }, { 242, 170.622374526 * 8 }, \ 
  { 250, 169.462988037 * 8 }, { 258, 168.322359206 * 8 }, { 266, 167.199797074 * 8 }, \ 
  { 274, 166.094644852 * 8 }, { 282, 165.006277708 * 8 }, { 291, 163.934100729 * 8 }, \ 
  { 299, 162.877547033 * 8 }, { 308, 161.836076037 * 8 }, { 317, 160.809171842 * 8 }, \ 
  { 326, 159.796341745 * 8 }, { 335, 158.79711486 * 8 }, { 344, 157.811040829 * 8 }, \ 
  { 353, 156.83768864 * 8 }, { 363, 155.876645509 * 8 }, { 372, 154.927515855 * 8 }, \ 
  { 382, 153.989920337 * 8 }, { 392, 153.063494955 * 8 }, { 402, 152.147890214 * 8 }, \ 
  { 412, 151.242770343 * 8 }, { 422, 150.347812558 * 8 }, { 433, 149.462706381 * 8 }, \ 
  { 443, 148.587152994 * 8 }, { 454, 147.720864641 * 8 }, { 464, 146.863564058 * 8 }, \ 
  { 475, 146.014983944 * 8 }, { 486, 145.174866462 * 8 }, { 497, 144.342962765 * 8 }, \ 
  { 509, 143.519032561 * 8 }, { 520, 142.702843688 * 8 }, { 531, 141.894171727 * 8 }, \ 
  { 543, 141.092799628 * 8 }, { 555, 140.298517358 * 8 }, { 567, 139.511121574 * 8 }, \ 
  { 579, 138.730415305 * 8 }, { 591, 137.95620766 * 8 }, { 603, 137.188313544 * 8 }, \ 
  { 615, 136.42655339 * 8 }, { 628, 135.670752915 * 8 }, { 640, 134.920742868 * 8 }, \ 
  { 653, 134.176358814 * 8 }, { 666, 133.437440909 * 8 }, { 679, 132.703833699 * 8 }, \ 
  { 692, 131.975385924 * 8 }, { 705, 131.251950327 * 8 }, { 718, 130.533383483 * 8 }, \ 
  { 732, 129.819545623 * 8 }, { 745, 129.110300475 * 8 }, { 759, 128.405515109 * 8 }, \ 
  { 773, 127.705059791 * 8 }, { 787, 127.008807838 * 8 }, { 801, 126.316635483 * 8 }, \ 
  { 815, 125.628421748 * 8 }, { 830, 124.944048316 * 8 }, { 844, 124.263399416 * 8 }, \ 
  { 859, 123.586361704 * 8 }, { 873, 122.912824152 * 8 }, { 888, 122.242677946 * 8 }, \ 
  { 903, 121.575816381 * 8 }, { 918, 120.912134764 * 8 }, { 934, 120.251530315 * 8 }, \ 
  { 949, 119.593902079 * 8 }, { 964, 118.939150837 * 8 }, { 980, 118.287179017 * 8 }, \ 
  { 996, 117.637890612 * 8 }, { 1012, 116.9911911 * 8 }, { 1028, 116.346987364 * 8 }, \ 
  { 1044, 115.705187616 * 8 }, { 1060, 115.065701323 * 8 }, { 1076, 114.428439132 * 8 }, \ 
  { 1093, 113.793312803 * 8 }, { 1109, 113.160235137 * 8 }, { 1126, 112.529119906 * 8 }, \ 
  { 1143, 111.899881792 * 8 }, { 1160, 111.272436317 * 8 }, { 1177, 110.64669978 * 8 }, \ 
  { 1194, 110.022589192 * 8 }, { 1211, 109.400022216 * 8 }, { 1229, 108.778917104 * 8 }, \ 
  { 1246, 108.159192635 * 8 }, { 1264, 107.540768055 * 8 }, { 1282, 106.923563015 * 8 }, \ 
  { 1300, 106.307497512 * 8 }, { 1318, 105.692491828 * 8 }, { 1336, 105.078466473 * 8 }, \ 
  { 1355, 104.465342118 * 8 }, { 1373, 103.853039543 * 8 }, { 1392, 103.241479569 * 8 }, \ 
  { 1410, 102.630583 * 8 }, { 1429, 102.020270564 * 8 }, { 1448, 101.410462843 * 8 }, \ 
  { 1467, 100.801080217 * 8 }, { 1487, 100.192042797 * 8 }, { 1506, 99.5832703583 * 8 }, \ 
  { 1525, 98.9746822764 * 8 }, { 1545, 98.366197457 * 8 }, { 1565, 97.7577342671 * 8 }, \ 
  { 1585, 97.149210464 * 8 }, { 1605, 96.5405431217 * 8 }, { 1625, 95.9316485557 * 8 }, \ 
  { 1645, 95.3224422455 * 8 }, { 1665, 94.7128387546 * 8 }, { 1686, 94.1027516476 * 8 }, \ 
  { 1706, 93.4920934045 * 8 }, { 1727, 92.8807753321 * 8 }, { 1748, 92.2687074715 * 8 }, \ 
  { 1769, 91.6557985021 * 8 }, { 1790, 91.0419556415 * 8 }, { 1811, 90.4270845413 * 8 }, \ 
  { 1832, 89.811089178 * 8 }, { 1854, 89.1938717388 * 8 }, { 1875, 88.5753325019 * 8 }, \ 
  { 1897, 87.9553697114 * 8 }, { 1919, 87.3338794449 * 8 }, { 1941, 86.7107554755 * 8 }, \ 
  { 1963, 86.0858891251 * 8 }, { 1985, 85.4591691107 * 8 }, { 2008, 84.8304813813 * 8 }, \ 
  { 2030, 84.1997089462 * 8 }, { 2053, 83.5667316926 * 8 }, { 2075, 82.9314261926 * 8 }, \ 
  { 2098, 82.2936654982 * 8 }, { 2121, 81.6533189235 * 8 }, { 2144, 81.0102518131 * 8 }, \ 
  { 2168, 80.3643252955 * 8 }, { 2191, 79.7153960194 * 8 }, { 2214, 79.0633158734 * 8 }, \ 
  { 2238, 78.4079316848 * 8 }, { 2262, 77.749084899 * 8 }, { 2286, 77.0866112338 * 8 }, \ 
  { 2310, 76.4203403102 * 8 }, { 2334, 75.750095255 * 8 }, { 2358, 75.0756922728 * 8 }, \ 
  { 2382, 74.3969401856 * 8 }, { 2407, 73.7136399358 * 8 }, { 2431, 73.0255840493 * 8 }, \ 
  { 2456, 72.3325560546 * 8 }, { 2481, 71.6343298533 * 8 }, { 2506, 70.9306690376 * 8 }, \ 
  { 2531, 70.2213261479 * 8 }, { 2556, 69.5060418653 * 8 }, { 2581, 68.7845441309 * 8 }, \ 
  { 2607, 68.0565471846 * 8 }, { 2632, 67.3217505124 * 8 }, { 2658, 66.5798376948 * 8 }, \ 
  { 2684, 65.8304751403 * 8 }, { 2710, 65.0733106938 * 8 }, { 2736, 64.3079721025 * 8 }, \ 
  { 2762, 63.5340653207 * 8 }, { 2789, 62.751172635 * 8 }, { 2815, 61.9588505835 * 8 }, \ 
  { 2842, 61.1566276427 * 8 }, { 2868, 60.3440016495 * 8 }, { 2895, 59.5204369205 * 8 }, \ 
  { 2922, 58.6853610246 * 8 }, { 2949, 57.8381611576 * 8 }, { 2977, 56.978180057 * 8 }, \ 
  { 3004, 56.1047113857 * 8 }, { 3031, 55.2169944974 * 8 }, { 3059, 54.3142084826 * 8 }, \ 
  { 3087, 53.3954653702 * 8 }, { 3115, 52.4598023382 * 8 }, { 3143, 51.5061727502 * 8 }, \ 
  { 3171, 50.5334358009 * 8 }, { 3199, 49.5403444971 * 8 }, { 3227, 48.5255316449 * 8 }, \ 
  { 3256, 47.4874934234 * 8 }, { 3284, 46.4245700307 * 8 }, { 3313, 45.3349227431 * 8 }, \ 
  { 3342, 44.2165065547 * 8 }, { 3371, 43.0670373278 * 8 }, { 3400, 41.8839520641 * 8 }, \ 
  { 3429, 40.6643604806 * 8 }, { 3458, 39.4049854821 * 8 }, { 3488, 38.1020893031 * 8 }, \ 
  { 3517, 36.7513809357 * 8 }, { 3547, 35.3478987996 * 8 }, { 3577, 33.8858601897 * 8 }, \ 
  { 3607, 32.3584654369 * 8 }, { 3637, 30.7576392338 * 8 }, { 3667, 29.0736830482 * 8 }, \ 
  { 3698, 27.2947988822 * 8 }, { 3728, 25.4064220819 * 8 }, { 3759, 23.3902623328 * 8 }, \ 
  { 3789, 21.222883268 * 8 }, { 3820, 18.8735227439 * 8 }, { 3851, 16.3006019629 * 8 }, \ 
  { 3882, 13.4458338789 * 8 }, { 3914, 10.2236009783 * 8 }, { 3945, 6.50008248413 * 8 }, \ 
  { 3976, 2.04712212963 * 8 }, { 4008, -3.57890494497 * 8 }, { 4040, -11.4602567911 * 8 }, \ 
  { 4040, -26.1177410752 * 8 } };
