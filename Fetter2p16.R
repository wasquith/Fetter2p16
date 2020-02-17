print(getwd()) # shows you were you are on computer, going to make output
library(dataRetrieval)

Flow <- readNWISstat("09380000", parameterCd="00060", statReportType="annual")
head(Flow) # the part 1 of the problem with probability table (sort of)
write.table(Flow, file="could_import_this_in_excel.csv", sep=",") # output

AnnualValues <- Flow$mean_va; Year <- Flow$year_nu
Qs <- sort(AnnualValues); Prob <- 1 - rank(Qs)/(length(Qs) + 1)
plot(Prob, Qs, type="l", xlab="Exceedance probability", ylab="Flow, cfs")

pdf("flow_duration_curve.pdf", height=5, width=6.5) # turn PDF in with code
  plot(qnorm(Prob), Qs, type="l", xlab="Standard deviations", ylab="Flow, cfs")
  mtext("09380000 Colorado River at Lees Ferry, AZ (INSERT YOUR R NUMBER HERE)")
dev.off() # close up the PDF graphics device
