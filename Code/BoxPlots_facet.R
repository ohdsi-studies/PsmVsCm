
z1 <- bal_all_1
z2 <- bal_all_2
z3 <- bal_all_3
z4 <- bal_all_4

y1 <- bal_match_1
y2 <- bal_match_2
y3 <- bal_match_3
y4 <- bal_match_4

for(j in 1:9){
  z2[[j]]$cohort <- "10% Subsample Group (N=17,210)"
  z3[[j]]$cohort <- "1% Subsample Group (N=1,720)"
  z4[[j]]$cohort <- "0.5% Subsample Group (N=860)"
  
  y2[[j]]$cohort <- "10% Subsample Group (N=17,210)"
  y3[[j]]$cohort <- "1% Subsample Group (N=1,720)"
  y4[[j]]$cohort <- "0.5% Subsample Group (N=860)"
  
  if(j == 9){
    next
  }
  
  z1[[j]]$cohort <- "Study Population (N=172,117)"
  y1[[j]]$cohort <- "Study Population (N=172,117)"
}

z <- list()
y <- list()
for(j in 1:9){
  if(j != 9){
    z[[j]] <- rbind(z1[[j]], z2[[j]], z3[[j]], z4[[j]])
    y[[j]] <- rbind(y1[[j]], y2[[j]], y3[[j]], y4[[j]])
  } else{
    z[[j]] <- rbind(z2[[j]], z3[[j]], z4[[j]])
    y[[j]] <- rbind(y2[[j]], y3[[j]], y4[[j]])
  }
}


x1 <- z
x2 <- y
for(j in 1:9){
  
  if(length(x1) < j){
    next
  }
  if(j == 1 | j == 2){
    x1[[j]]$Analysis <- "PSM"
    x1[[j]]$parameter <- j + 1
  } else if(j == 3 | j == 4 | j == 5 | j == 9){
    x1[[j]]$Analysis <- "CM"
    if(j == 9){
      x1[[j]]$parameter <- 4
    } else{
      x1[[j]]$parameter <- j + 2
    }
  } else{
    x1[[j]]$Analysis <- "CM, ATC estimand"
    x1[[j]]$parameter <- j + 2
  }
  
  if(length(x2) < j){
    next
  }
  if(j == 1 | j == 2){
    x2[[j]]$Analysis <- "PSM"
    x2[[j]]$parameter <- j
  } else if(j == 3 | j == 4 | j == 5 | j == 9){
    x2[[j]]$Analysis <- "CM"
    if(j == 9){
      x2[[j]]$parameter <- 3
    } else{
      x2[[j]]$parameter <- j+1
    }
  } else{
    x2[[j]]$Analysis <- "CM, ATC estimand"
    x2[[j]]$parameter <- j+1
  }
  
}
temp <- x1[[1]]
temp$parameter=1
temp$Analysis="Pre-match"
temp$afterMatchingStdDiff <- temp$beforeMatchingStdDiff
x1 <- rbind(temp, do.call(rbind, x1))
x2 <- do.call(rbind, x2)
x1$cohort <- factor(x1$cohort, levels = c("Study Population (N=172,117)", "10% Subsample Group (N=17,210)", 
                                          "1% Subsample Group (N=1,720)", "0.5% Subsample Group (N=860)"))
x1$Analysis <- factor(x1$Analysis, levels = c("Pre-match", "PSM", "CM", "CM, ATC estimand"))
x2$cohort <- factor(x2$cohort, levels = c("Study Population (N=172,117)", "10% Subsample Group (N=17,210)", 
                                          "1% Subsample Group (N=1,720)", "0.5% Subsample Group (N=860)"))
x2$Analysis <- factor(x2$Analysis, levels = c("PSM", "CM", "CM, ATC estimand"))


p1<- ggplot(x1, aes(group=parameter, x=parameter, y=afterMatchingStdDiff, fill=Analysis)) + 
  geom_boxplot() +
  labs(x="Parameter Settings", y="Standardized Mean Difference") +
  scale_x_discrete(limit=c(1:9),
                   labels=c("pre-match", "caliper=0.10", "caliper=0.20",
                            "fine balance", "max SMD=0.01", "max SMD=0.05", "max SMD=0.10",
                            "max SMD=0.01", "max SMD=0.05", "max SMD=0.10")) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  ylim(-0.5, 0.5) +
  geom_hline(yintercept=c(-0.1, 0.1), linetype='dashed')
p1 + facet_wrap( ~ cohort, ncol=2)




p2 <- ggplot(x2, aes(group=parameter, x=parameter, y=afterMatchingStdDiff, fill=Analysis)) + 
  geom_boxplot() +
  labs(x="Parameter Settings", y="Standardized Mean Difference") +
  scale_x_discrete(limit=c(1:9),
                   labels=c("caliper=0.10", "caliper=0.20",
                            "fine balance", "max SMD=0.01", "max SMD=0.05", "max SMD=0.10",
                            "max SMD=0.01", "max SMD=0.05", "max SMD=0.10")) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  geom_hline(yintercept=c(-0.1, 0.1), linetype='dashed')
p2 + facet_wrap( ~ cohort,  ncol=2)




#########################################################################################################



z1 <- bal_all_1
z2 <- bal_all_2
z3 <- bal_all_3
z4 <- bal_all_4

y1 <- bal_match_1
y2 <- bal_match_2
y3 <- bal_match_3
y4 <- bal_match_4

for(j in 1:9){
  z2[[j]]$cohort <- "10% Subsample Group (N=17,210)"
  z3[[j]]$cohort <- "1% Subsample Group (N=1,720)"
  z4[[j]]$cohort <- "0.5% Subsample Group (N=860)"
  
  y2[[j]]$cohort <- "10% Subsample Group (N=17,210)"
  y3[[j]]$cohort <- "1% Subsample Group (N=1,720)"
  y4[[j]]$cohort <- "0.5% Subsample Group (N=860)"
  
  if(j == 9){
    next
  }
  
  z1[[j]]$cohort <- "Study Population (N=172,117)"
  y1[[j]]$cohort <- "Study Population (N=172,117)"
}

z <- list()
y <- list()
for(j in 1:9){
  if(j != 9){
    z[[j]] <- rbind(z1[[j]], z2[[j]], z3[[j]], z4[[j]])
    y[[j]] <- rbind(y1[[j]], y2[[j]], y3[[j]], y4[[j]])
  } else{
    z[[j]] <- rbind(z2[[j]], z3[[j]], z4[[j]])
    y[[j]] <- rbind(y2[[j]], y3[[j]], y4[[j]])
  }
}


x1 <- z
x2 <- y
for(j in 1:9){
  
  if(length(x1) < j){
    next
  }
  if(j == 1 | j == 2){
    x1[[j]]$Analysis <- "PSM"
    x1[[j]]$parameter <- j + 1
  } else if(j == 3 | j == 4 | j == 5 | j == 9){
    x1[[j]]$Analysis <- "CM"
    if(j == 9){
      x1[[j]]$parameter <- 4
    } else{
      x1[[j]]$parameter <- j + 2
    }
  } else{
    x1[[j]]$Analysis <- "CM, ATC estimand"
    x1[[j]]$parameter <- j + 2
  }
  
  if(length(x2) < j){
    next
  }
  if(j == 1 | j == 2){
    x2[[j]]$Analysis <- "PSM"
    x2[[j]]$parameter <- j
  } else if(j == 3 | j == 4 | j == 5 | j == 9){
    x2[[j]]$Analysis <- "CM"
    if(j == 9){
      x2[[j]]$parameter <- 3
    } else{
      x2[[j]]$parameter <- j+1
    }
  } else{
    x2[[j]]$Analysis <- "CM, ATC estimand"
    x2[[j]]$parameter <- j+1
  }
  
}
temp <- x1[[1]]
temp$parameter=1
temp$Analysis="Pre-match"
temp$afterMatchingStdDiff <- temp$beforeMatchingStdDiff

x1 <- x1[-c(6:8)]
x1 <- rbind(temp, do.call(rbind, x1))

x2 <- do.call(rbind, x2)
x1$cohort <- factor(x1$cohort, levels = c("Study Population (N=172,117)", "10% Subsample Group (N=17,210)", 
                                          "1% Subsample Group (N=1,720)", "0.5% Subsample Group (N=860)"))
x1$Analysis <- factor(x1$Analysis, levels = c("Pre-match", "PSM", "CM", "CM, ATC estimand"))
x2$cohort <- factor(x2$cohort, levels = c("Study Population (N=172,117)", "10% Subsample Group (N=17,210)", 
                                          "1% Subsample Group (N=1,720)", "0.5% Subsample Group (N=860)"))
x2$Analysis <- factor(x2$Analysis, levels = c("PSM", "CM", "CM, ATC estimand"))
x1 <- x1[x1$Analysis != "CM, ATC estimand",]
x2 <- x2[x2$Analysis != "CM, ATC estimand",]


x1$Group <- "Covariate Candidates"
x2$Group <- "Matching Covariates"
x3 <- rbind(x1, x2)
x3$Group <- factor(x3$Group, levels = c("Covariate Candidates", "Matching Covariates"))
x3 <- x3[x3$Analysis != "CM, ATC estimand",]


p1<- ggplot(x3, aes(group=parameter, x=parameter, y=afterMatchingStdDiff, fill=Analysis)) + 
  geom_boxplot() +
  labs(x="Parameter Settings", y="Standardized Mean Difference") +
  scale_x_discrete(limit=c(1:9),
                   labels=c("pre-match", "caliper=0.10", "caliper=0.20",
                            "fine balance", "max SMD=0.01", "max SMD=0.05", "max SMD=0.10",
                            "max SMD=0.01", "max SMD=0.05", "max SMD=0.10")) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1)) +
  ylim(-0.5, 0.5) +
  geom_hline(yintercept=c(-0.1, 0.1), linetype='dashed')
p1 + facet_wrap( ~ cohort + Group)


p1<- ggplot(x1, aes(group=parameter, x=parameter, y=afterMatchingStdDiff, fill=Analysis)) + 
  geom_boxplot() +
  labs(title="Covariate Candidates", x="Parameter Settings", y="Standardized Mean Difference") +
  scale_x_discrete(limit=c(1:7),
                   labels=c("pre-match", "caliper=0.10", "caliper=0.20",
                            "fine balance", "max SMD=0.01", "max SMD=0.05", "max SMD=0.10")) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1), plot.title = element_text(hjust=0.5)) +
  geom_hline(yintercept=c(-0.1, 0.1), linetype='dashed') +
  ylim(-0.5, 0.5)
p1 + facet_wrap( ~ cohort, ncol=1)




p2 <- ggplot(x2, aes(group=parameter, x=parameter, y=afterMatchingStdDiff, fill=Analysis)) + 
  geom_boxplot() +
  labs(title="Matching Covariates", x="Parameter Settings", y="Standardized Mean Difference") +
  scale_x_discrete(limit=c(1:6),
                   labels=c("caliper=0.10", "caliper=0.20",
                            "fine balance", "max SMD=0.01", "max SMD=0.05", "max SMD=0.10")) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1), plot.title = element_text(hjust=0.5)) +
  geom_hline(yintercept=c(-0.1, 0.1), linetype='dashed') +
  ylim(-0.5, 0.5)
p2 + facet_wrap( ~ cohort,  ncol=1)




#########################################################################################################



y1 <- bal_match_1
y2 <- bal_match_2
y3 <- bal_match_3
y4 <- bal_match_4

for(j in 1:9){
  y2[[j]]$cohort <- "10% Subsample Group (N=17,210)"
  y3[[j]]$cohort <- "1% Subsample Group (N=1,720)"
  y4[[j]]$cohort <- "0.5% Subsample Group (N=860)"
  
  if(j == 9){
    next
  }

  y1[[j]]$cohort <- "Study Population (N=172,117)"
}

y <- list()
for(j in 1:9){
  if(j != 9){
    y[[j]] <- rbind(y1[[j]], y2[[j]], y3[[j]], y4[[j]])
  } else{
    y[[j]] <- rbind(y2[[j]], y3[[j]], y4[[j]])
  }
}


x2 <- y
for(j in 1:9){
  
  if(length(x2) < j){
    next
  }
  if(j == 1 | j == 2){
    x2[[j]]$Analysis <- "PSM"
    x2[[j]]$parameter <- j + 1
  } else if(j == 3 | j == 4 | j == 5 | j == 9){
    x2[[j]]$Analysis <- "CM"
    if(j == 9){
      x2[[j]]$parameter <- 4
    } else{
      x2[[j]]$parameter <- j + 2
    }
  } else{
    x2[[j]]$Analysis <- "CM, ATC estimand"
    x2[[j]]$parameter <- j + 2
  }
  
}

temp <- x2[[1]]
temp$parameter=1
temp$Analysis="Pre-match"
temp$afterMatchingStdDiff <- temp$beforeMatchingStdDiff

x2 <- x2[-c(6:8)]
x2 <- rbind(temp, do.call(rbind, x2))

x2$cohort <- factor(x2$cohort, levels = c("Study Population (N=172,117)", "10% Subsample Group (N=17,210)", 
                                          "1% Subsample Group (N=1,720)", "0.5% Subsample Group (N=860)"))
x2$Analysis <- factor(x2$Analysis, levels = unique(x2$Analysis))

x2 <- x2[x2$Analysis != "CM, ATC estimand",]


p1<- ggplot(x2, aes(group=parameter, x=parameter, y=afterMatchingStdDiff, fill=Analysis)) + 
  geom_boxplot() +
  labs(title="Covariate Candidates", x="Parameter Settings", y="Standardized Mean Difference") +
  scale_x_discrete(limit=c(1:7),
                   labels=c("pre-match", "caliper=0.10", "caliper=0.20",
                            "fine balance", "max SMD=0.01", "max SMD=0.05", "max SMD=0.10")) +
  theme(axis.text.x = element_text(angle=90, vjust=0.5, hjust=1), plot.title = element_text(hjust=0.5)) +
  geom_hline(yintercept=c(-0.1, 0.1), linetype='dashed') +
  ylim(-0.5, 0.5)
p1 + facet_wrap( ~ cohort, ncol=2)












