
#' ## Graphs

library(lattice)

set.seed(2015+1)
patient <- c(1:20)
height <- rnorm(20, 1.70, 0.1)
weight <- rnorm(20, 70, 10)
sex <- sample(1:2, 20, replace = T)
sex <- factor(sex, levels = 1:2, labels = c("male", "female"))

dat <- data.frame(patient, height, weight, sex)
dat$BMI <- dat$weight/(dat$height^2)
dat$weight_65higher <- as.numeric(dat$weight > 65)
dat$weight_65higher <- factor(dat$weight_65higher, levels = 0:1, labels = c("low", "high"))

plot(dat$weight)
plot(dat$weight, dat$height)
plot(dat$weight, dat$BMI)

plot(dat$weight, xlab = "patient", ylab = "weight", main = "Scatterplot")
plot(dat$weight, dat$height, xlab = "weight", ylab = "height", main = "Scatterplot")
plot(dat$weight, dat$BMI, xlab = "weight", ylab = "BMI", main = "Scatterplot")
plot(dat$weight, dat$BMI, col = dat$sex, xlab = "weight", ylab = "BMI", main = "Scatterplot",
     pch = 1)
legend(60,35, c("male", "female"), col = 1:2, pch = 1)
plot(dat$weight, dat$BMI, col = dat$sex, xlab = "weight", ylab = "BMI", main = "Scatterplot",
     pch = 2)
legend(60,35, c("male", "female"), col = 1:2, pch = 2)
plot(dat$weight, xlab = "weight", ylab = "BMI", main = "Scatterplot",
     type = "l")
plot(dat$weight, xlab = "weight", ylab = "BMI", main = "Scatterplot",
     type = "b")

plot(dat$weight, xlab = "weight", ylab = "BMI", main = "Scatterplot",
     type = "o")

plot(dat$weight, xlab = "weight", ylab = "BMI", main = "Scatterplot",
     type = "o", cex.lab=1.2, cex.axis=1.4)

barplot(table(dat$weight_65higher))
barplot(c(1,2,3), names.arg = c('JOhn', 'Paul', 'Ringo') )

boxplot(dat$height, main = "boxplot")
boxplot(height ~ sex, data = dat, main = "boxplot")
boxplot(height ~ sex, data = dat, main = "boxplot", horizontal = TRUE)

dotplot(tapply(dat$weight, dat$sex, mean))

hist(dat$weight)
hist(dat$weight, breaks = seq(50, 85, 2))
hist(dat$weight, breaks = 10)
hist(dat$weight, freq = FALSE)
lines(density(dat$weight))

#pdf(file = 'plot4.pdf')
par(mfrow=c(2,2))
hist(dat$weight, main = "histogram")
hist(dat$height, main = "histogram")
hist(dat$BMI, main = "histogram")
pie(table(dat$sex))
#dev.off()

xyplot(weight ~ BMI | sex, main = "Weight vs BMI per sex", data = dat)
xyplot(weight ~ BMI, group = sex, pch = c(4, 8), col = c(1,1),
       main = "Weight vs BMI per sex", data = dat)
xyplot(weight ~ BMI, group = sex, pch = c(1, 1), col = c(1,2),
       main = "Weight vs BMI per sex", data = dat)
xyplot(weight ~ BMI, group = sex, pch = c(4, 8),
       type = c("smooth", "p"),
       main = "Weight vs BMI per sex", data = dat)
xyplot(weight ~ BMI, group = sex, pch = c(4, 8),
       type = c("smooth", "p"),
       main = "Weight vs BMI per sex", data = dat, ylim = c(55,95))
xyplot(weight ~ BMI | sex, type = c("p", "smooth"),
       main = "Weight vs BMI per sex", ylim = c(55,95), data = dat)
dat$upWeight <- dat$weight + 1.96*sd(dat$weight)
dat$lowWeight <- dat$weight - 1.96*sd(dat$weight)
xyplot(weight + upWeight + lowWeight ~ BMI | sex,
       type = "smooth", col = c(1, 1, 1),
       lwd = c(2, 2, 2), lty = c(1, 2, 2),
       main = "Weight vs BMI per sex",
       ylim = c(35, 110), data = dat)

pairs(dat[,c(2,3,5)])

par(mfrow=c(2,3))
hist(dat$weight, main = "histogram")
boxplot(dat$height, main = "boxplot")
boxplot(height ~ sex, data = dat)
plot(dat$weight, dat$BMI, xlab = "weight",
     ylab = "BMI", main = "Scatterplot")
plot(dat$weight[dat$sex == "female"], ylab = "weight")
points(dat$weight[dat$sex == "male"], col = 2)
lines(dat$weight[dat$sex == "male"], col = 3)
dev.off()
par(mar=c(5.1,4.1, 2, 2.1)) # CHANGE MARGINS
plot(dat$height, dat$weight)
points(x = 1.6, y=65, cex=3)
lines(c(1.5, 1.8), c(55,75), lwd=3, lty=3)
polygon(y=c(60,70, 70, 60),
        x=c(1.5, 1.5, 1.7, 1.7),
        col='#22334488',
        border = 'blue')
segments(x0=c(1.5, 1.6), x1=c(1.6, 1.8), y0=c(60, 70), y1=c(70, 60),
         col='orange', lwd=2)
abline(h=65, lty=2, lwd=3)
abline(v=1.7, lty=2, lwd=3)
abline(a=31, b=21)
text(1.5, 60, "hello")
mtext(side=1, text = "Hi")  # text in margin
axis(side = 3, at=c(1.5, 1.8), labels = c('A', 'B')) # add custom axis
