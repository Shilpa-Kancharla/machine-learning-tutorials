> dist.1=daisy(USArrests); mds.1=cmdscale(dist.1)
> dist.2=daisy(USArrests, metric="manhattan"); mds.2=cmdscale(dist.2)
>
> x=mds.1[,1]
> y=mds.1[,2]
>
> plot(x, y, xlab = "Coordinate 1", ylab = "Coordinate 2",
xlim = range(x)*1.2, type = "n", main=’Euclidean Dist’)
> text(x, y, labels = rownames(USArrests), col=’blue’, cex=0.7)
