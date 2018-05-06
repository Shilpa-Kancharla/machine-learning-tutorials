> states <- row.names(USArrests)
> states[1:5]
[1] "Alabama" "Alaska" "Arizona" "Arkansas" "California"

> apply(USArrests, 2, mean)
Murder Assault UrbanPop Rape
7.788 170.760 65.540 21.232

> apply(USArrests, 2, var)
Murder Assault UrbanPop Rape
18.97047 6945.16571 209.51878 87.72916

> pc.out <- prcomp(USArrests, scale=TRUE)
> print(pc.out$rot)
                      PC1 PC2 PC3 PC4
                      
Murder -0.5358995 0.4181809 -0.3412327 0.64922780
Assault -0.5831836 0.1879856 -0.2681484 -0.74340748
UrbanPop -0.2781909 -0.8728062 -0.3780158 0.13387773
Rape -0.5434321 -0.1673186 0.8177779 0.08902432
