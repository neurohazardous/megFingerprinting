#######################################################################
#
#
#             Script for plotting Fingerpritning Results
#                 and PLS analysis with ggplot
#
######################################################################
# Load libraries 
library(ggplot2)
library(RColorBrewer)
############################### Plot Within-Session Results  #######################################
df=read.csv("./output/OMEGA_Fingerprint_data_for_plot.csv", header = TRUE)
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High \n Gamma", "Broadband"))
df$dataset=plyr::mapvalues(df$dataset, unique(df$dataset), c("   Dataset 1 -> 2", "   Dataset 2 -> 1"))
df_psd=df[df$Method=="PSD",]
df_aec=df[df$Method=="AEC",]
df_d1=df[df$dataset =="   Dataset 1 -> 2",]

ggplot(data=df_psd, aes(x=band, y=ACC, fill=dataset)) +  coord_cartesian(ylim=c(75,100))+geom_bar(width=0.5,stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="") + theme(text = element_text(size=40), legend.title=element_blank())

ggplot(data=df_aec, aes(x=band, y=ACC, fill=dataset)) +  coord_cartesian(ylim=c(75,100))+geom_bar(width=0.5,stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="") + theme(text = element_text(size=40), legend.title=element_blank())

ggplot(data=df_d1, aes(x=band, y=ACC, fill=Method)) +  coord_cartesian(ylim=c(85,100))+geom_bar(width=0.5,stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="") + theme(text = element_text(size=40), legend.title=element_blank())


############################### Plots Within-Session Shortened Results  #######################################
df=read.csv("./output/OMEGA_Fingerprinting_data_short_for_plot.csv", header = TRUE, stringsAsFactors = FALSE)
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High\nGamma", "Broadband"))
df$dataset[df$dataset=="d" & df$Dataset_parent=="D1D2"] = "   Dataset 1 -> 2"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D1D2"] = "   Dataset 2 -> 1"
df$dataset[df$dataset=="d" & df$Dataset_parent=="D1D3"] = "   Dataset 1 -> 3"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D1D3"] = "   Dataset 3 -> 1"
df$dataset[df$dataset=="d" & df$Dataset_parent=="D2D3"] = "   Dataset 2 -> 3"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D2D3"] = "   Dataset 3 -> 2"

df$dataset= factor(df$dataset,levels = c("   Dataset 1 -> 2", "   Dataset 2 -> 1", "   Dataset 2 -> 3", "   Dataset 3 -> 2", "   Dataset 1 -> 3", "   Dataset 3 -> 1"))
df$Dataset_parent= factor(df$Dataset_parent,levels = c("D1D2", "D2D3", "D1D3"))

df_psd=df[df$Method=="PSD",]
df_aec=df[df$Method=="AEC",]
df_data=df[df$dataset %in%   c("   Dataset 1 -> 2", "   Dataset 2 -> 3", "   Dataset 1 -> 3"),]

df_psd_2=df[df$Method=="PSD"  & df$Dataset_parent == "D1D3",]
df_aec_2=df[df$Method=="AEC" & df$Dataset_parent == "D1D3",]

ggplot(data=df_psd, aes(x=band, y=ACC, fill=dataset, width=.5)) +  coord_cartesian(ylim=c(20,100))+geom_bar(stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="",title="") + facet_wrap(~Dataset_parent, nrow = 3, labeller = labeller(Dataset_parent = c("   ", "  ", "  "))) + theme(text = element_text(size=40), legend.title=element_blank())

ggplot(data=df_aec, aes(x=band, y=ACC, fill=dataset, width=.5)) +  coord_cartesian(ylim=c(20,100))+geom_bar(stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="",title="") + facet_wrap(~Dataset_parent, nrow = 3, labeller = labeller(Dataset_parent = c("   ", "  ", "  "))) + theme(text = element_text(size=40), legend.title=element_blank())

ggplot(data=df_data, aes(x=band, y=ACC, fill=Method, width=.5)) +  coord_cartesian(ylim=c(20,100))+geom_bar(stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="",title="") + facet_wrap(~Dataset_parent, nrow = 3, labeller = labeller(Dataset_parent = c("   ", "  ", "  "))) + theme(text = element_text(size=40), legend.title=element_blank())

############################### Plot Between-Session Results  #######################################
df=read.csv("./output/OMEGA_Fingerprinting_data_two_session_for_plot.csv", header = TRUE)
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High \n Gamma", "Broadband"))
df$dataset=plyr::mapvalues(df$dataset, unique(df$dataset), c("   Dataset 1 -> 2", "   Dataset 2 -> 1"))
df_psd=df[df$Method=="PSD",]
df_aec=df[df$Method=="AEC",]
df_d1=df[df$dataset =="   Dataset 1 -> 2",]

ggplot(data=df_psd, aes(x=band, y=ACC, fill=dataset)) +  coord_cartesian(ylim=c(70,100))+geom_bar(width=0.5,stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="") + theme(text = element_text(size=40), legend.title=element_blank())

ggplot(data=df_aec, aes(x=band, y=ACC, fill=dataset)) +  coord_cartesian(ylim=c(70,100))+geom_bar(width=0.5,stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="") + theme(text = element_text(size=40), legend.title=element_blank())

ggplot(data=df_d1, aes(x=band, y=ACC, fill=Method)) +  coord_cartesian(ylim=c(70,100))+geom_bar(width=0.5,stat = "identity", position=position_dodge(width = 0.5)) +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="") + theme(text = element_text(size=40), legend.title=element_blank())


############################### Plot PLS Variance Explained #######################################
df=read.csv("./output/AEC_components_var.csv", header = TRUE, stringsAsFactors = FALSE) # Chnage file for AEC or PSD
cutoff <- data.frame( x = c(-Inf, Inf), y = 0.05, cutoff = factor(50) )

ggplot(data=df, aes(x=component, y=var)) +geom_line(data = df, aes(x = component, y = var),colour= "grey75", size=5) + geom_point(size=10, colour="grey65")  + geom_line(aes( x, y, linetype = cutoff ), cutoff, linetype="dotted",size =5, colour="Grey") +geom_point(aes(x=component, y=p_value), colour= "lightcoral", size=10, shape=20) + scale_y_continuous(sec.axis = sec_axis(~.*1, name = "P Value", )) + theme_minimal() + labs(y="Covariance Explained (%)", x="Latent Variable",title="")+ theme(text = element_text(size=40), legend.title=element_blank()) + theme(axis.text.y.right = element_text(color = "lightpink3"), axis.title.y.right = element_text(color="lightpink3")) 


############################### Plots PLS Loadings #######################################
df=read.csv("./output/PSD_bootstrap.csv", header = TRUE, stringsAsFactors = FALSE) # Chnage file for AEC or PSD
df$feat=as.factor(df$feat)
df_1= df[df$component==1,]
df_2=df[df$component==2,]

cbbPalette <- c( "#5BD4E5", "#fec8c1", "#bdeaee","#FF8C94", "#D55E00", "#CC79A7")
# First Component 
ggplot(data=df_1, aes(x=feat, y=value, fill=feat)) + geom_bar(stat = "identity", width = 1) +theme_minimal() + theme(text = element_text(size=40), legend.title=element_blank(), legend.position = c(-1.7, -1.2)) + labs(y="Design Salience", x="",title="") + coord_flip() +   geom_errorbar(aes(ymin=lower, ymax=upper), width=.2)  + scale_fill_manual(values=cbbPalette)
# Second Component 
ggplot(data=df_2, aes(x=feat, y=value, fill=feat)) + geom_bar(stat = "identity", width = 1) +theme_minimal() + theme(text = element_text(size=40), legend.title=element_blank(), legend.position = c(-1.7, -1.2)) + labs(y="Design Salience", x="",title="") + coord_flip() +   geom_errorbar(aes(ymin=lower, ymax=upper), width=.2) + scale_fill_manual(values=cbbPalette)


############################### scatter plot of all fingerprinting  #######################################
rm(df, df2, data_plot)
df=read.csv("Desktop/OMEGA_Fingerprinting_data_two_session_for_plot.csv", header = TRUE)
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High\nGamma", "Broadband"))
df$dataset=plyr::mapvalues(df$dataset, unique(df$dataset), c("   Dataset 1 -> 2", "   Dataset 2 -> 1"))

data_plot=df[,1:4]
df=read.csv("Desktop/OMEGA_Fingerprint_data_for_plot.csv", header = TRUE)
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High\nGamma", "Broadband"))
df$dataset=plyr::mapvalues(df$dataset, unique(df$dataset), c("   Dataset 1 -> 2", "   Dataset 2 -> 1"))

data_plot=rbind(data_plot,df[,1:4])

df=read.csv("Desktop/OMEGA_Fingerprinting_data_short_for_plot.csv", header = TRUE, stringsAsFactors = FALSE)
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High\nGamma", "Broadband"))
df$dataset[df$dataset=="d" & df$Dataset_parent=="D1D2"] = "   Dataset 1 -> 2"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D1D2"] = "   Dataset 2 -> 1"
df$dataset[df$dataset=="d" & df$Dataset_parent=="D1D3"] = "   Dataset 1 -> 3"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D1D3"] = "   Dataset 3 -> 1"
df$dataset[df$dataset=="d" & df$Dataset_parent=="D2D3"] = "   Dataset 2 -> 3"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D2D3"] = "   Dataset 3 -> 2"

data_plot=rbind(data_plot,df[,2:5])

df=read.csv("Desktop/OMEGA_short_review_complete_full.csv", header = TRUE, stringsAsFactors = FALSE)
df2=read.csv("Desktop/OMEGA_fingerprinting_reviewer_short_2session.csv", header = TRUE, stringsAsFactors = FALSE)
df=rbind(df,df2[,1:5])
df$ACC=as.numeric(df$ACC)*100
df$band= factor(df$band,levels = c("Fullband", "Delta", "Theta", "Alpha", "Beta", "Gamma", "High Gamma"))
df$band=plyr::mapvalues(df$band, unique(df$band), c("Delta", "Theta", "Alpha", "Beta", "Gamma", "High\nGamma", "Broadband"))
df$dataset[df$dataset=="d" & df$Dataset_parent=="D1D2"] = "   identify dataset 2 from 1"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D1D2"] = "   identify dataset 1 from 2"
df$dataset[df$dataset=="d" & df$Dataset_parent=="D1D3"] = "   identify dataset 2 from 1"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D1D3"] = "   identify dataset 1 from 2"
df$dataset[df$dataset=="d" & df$Dataset_parent=="D2D3"] = "   identify dataset 2 from 1"
df$dataset[df$dataset=="t" & df$Dataset_parent=="D2D3"] = "   identify dataset 1 from 2"

data_plot=rbind(data_plot,df[,2:5])
data_plot$dataset[data_plot$band=='High   Gamma']="High Gamma"


cbbPalette <- c( "#6683f8","#f483a1", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#f3b2bf")
pd <- position_dodge(-0.6)
jitter <- position_jitter(width = 0.01, height = 0)
ggplot(data=data_plot, aes(x=band, y=ACC, colour=Method, width=.5)) +  geom_jitter( position= position_jitterdodge(jitter.width=0.1,dodge.width=-0.6), size=4 )+ stat_summary(fun.data = mean_se, geom = "errorbar", size=2.5, width=0.5, position = pd) +
  stat_summary(fun.data = "mean_cl_boot", geom = "point", size= 10, position = pd)  +theme_minimal() + scale_fill_grey() + labs(y="Accuracy (%)", x="",title="") +  theme(text = element_text(size=40), legend.title=element_blank()) + scale_color_manual(values=cbbPalette)

dodge <- position_dodge(width = 0.6)
ggplot(data=data_plot, aes(x=band, y=ACC, colour=Method, width=.5)) +  geom_jitter(position= position_jitterdodge(jitter.width=0.3, dodge.width=0.7), size=4, alpha=0.5 ) + stat_summary(fun.data = mean_se, geom = "errorbar", size=2.5, width=0, position = dodge)  +
  stat_summary(fun.data = "mean_cl_boot", geom = "point", size= 10, position = dodge)  +theme_minimal() + labs(y="Accuracy (%)", x="",title="") +  theme(text = element_text(size=40), legend.title=element_blank()) + scale_color_manual(values=cbbPalette) 


data_plot %>% group_by(band) %>% summarize(ACC1=mean(ACC))
data_plot %>% group_by(band, Method) %>% summarize(ACC1=mean(ACC))



########################################################
# plotting brains with ggseg
########################################################
library(ggseg)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
someData <- tibble(
  region = rep(c("transverse temporal", "insula",
                 "precentral","superior parietal"), 2), 
  p = sample(seq(0.5,1,.01), 8),
  groups = c(rep("g1", 4), rep("g2", 4))
)


df=read.csv('~/Desktop/McGill/python_codes/PSD_ICC_orig_atlas.csv', header = FALSE, stringsAsFactors = FALSE)
colnames(df)[1]='region'
df$hemi[] =''
df$hemi[seq(2,68,2)] ='right'
df$hemi[seq(1,67,2)] ='left'
#df$region[seq(1,68,2)]=paste('lh_', df$region[seq(1,68,2)], sep='')
#df$region[seq(2,68,2)]=paste('rh_', df$region[seq(2,68,2)], sep='')

# delta
someData= tibble(df$region, rowMeans(df[,2:9]), df$hemi)
colnames(someData)[2]='p'
colnames(someData)[1]='region'
colnames(someData)[3]='hemi'
someData$p[someData$p<0.4]=0.4
someData$p[someData$p>0.8]=0.8
ggplot(someData) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = p)) +
  scale_fill_distiller(palette = "RdBu"
                       , limits = c(0.4, 0.8))+
  #viridis::scale_fill_viridis(option = 'magma',limits=c(0.4, 0.8 ))+
  #scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                     midpoint=0.6,   
  #                     limits=c(0.4, 0.8 ))+
  theme_void() +
  labs(title = "delta")
#> merging atlas and data by 'region'
ggsave('~/Desktop/figure_DRAFTS/new_topo/ICC_Delta_m', device = "pdf")



# theta
someData= tibble(df$region, rowMeans(df[,10:17]), df$hemi)
colnames(someData)[2]='p'
colnames(someData)[1]='region'
colnames(someData)[3]='hemi'
someData$p[someData$p<0.4]=0.4
someData$p[someData$p>0.8]=0.8
ggplot(someData) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = p)) +
  #viridis::scale_fill_viridis(option = 'magma',limits=c(0.4, 0.8 ))+
  scale_fill_distiller(palette = "RdBu"
                       , limits = c(0.4, 0.8))+
  # scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                      midpoint=0.6,   
  #                      limits=c(0.4, 0.8 ))+
  theme_void() +
  labs(title = "theta")
#> merging atlas and data by 'region'
ggsave('~/Desktop/figure_DRAFTS/new_topo/ICC_Theta_m', device = "pdf")



# alpha
someData= tibble(df$region, rowMeans(df[,18:27]),df$hemi)
colnames(someData)[2]='p'
colnames(someData)[1]='region'
colnames(someData)[3]='hemi'
someData$p[someData$p<0.4]=0.4
someData$p[someData$p>0.8]=0.8
ggplot(someData) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = p)) +
  #viridis::scale_fill_viridis(option = 'magma',limits=c(0.4, 0.8 ))+
  scale_fill_distiller(palette = "RdBu"
                       , limits = c(0.4, 0.8))+
  #scale_fill_gradient(brewer.pal(n = 2, name = "Reds")) +
  # scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                      midpoint=0.6,   
  #                      limits=c(0.4, 0.8 ))+
  theme_void() +
  labs(title = "Alpha")
#> merging atlas and data by 'region'
ggsave('~/Desktop/figure_DRAFTS/new_topo/ICC_Alpha_m', device = "pdf")


# beta
someData= tibble(df$region, rowMeans(df[,28:61]),df$hemi)
colnames(someData)[2]='p'
colnames(someData)[1]='region'
colnames(someData)[3]='hemi'
someData$p[someData$p<0.4]=0.4
someData$p[someData$p>0.8]=0.8
ggplot(someData) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = p)) +
  #viridis::scale_fill_viridis(option = 'magma',limits=c(0.4, 0.8 ))+
  scale_fill_distiller(palette = "RdBu"
                       , limits = c(0.4, 0.8))+
  #scale_fill_gradient(brewer.pal(n = 2, name = "Reds")) +
  # scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                      midpoint=0.6,   
  #                      limits=c(0.4, 0.8 ))+
  theme_void() +
  labs(title = "Beta")
#> merging atlas and data by 'region'
ggsave('~/Desktop/figure_DRAFTS/new_topo/ICC_Beta_rb', device = "pdf")



# gamma
someData= tibble(df$region, rowMeans(df[,62:101]),df$hemi)
colnames(someData)[2]='p'
colnames(someData)[1]='region'
colnames(someData)[3]='hemi'
someData$p[someData$p<0.4]=0.4
someData$p[someData$p>0.8]=0.8
ggplot(someData) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = p)) +
  scale_fill_distiller(palette = "RdBu"
                       , limits = c(0.4, 0.8))+
  #viridis::scale_fill_viridis(option = 'magma',limits=c(0.4, 0.8 ))+
  #scale_fill_gradient(brewer.pal(n = 2, name = "Reds")) +
  # scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                      midpoint=0.6,   
  #                      limits=c(0.4, 0.8 ))+
  theme_void() +
  labs(title = "Gamma")
#> merging atlas and data by 'region'
ggsave('~/Desktop/figure_DRAFTS/new_topo/ICC_Gamma_m', device = "pdf")



# Hgamma
someData= tibble(df$region, rowMeans(df[,102:302]),df$hemi)
colnames(someData)[2]='p'
colnames(someData)[1]='region'
colnames(someData)[3]='hemi'
someData$p[someData$p<0.4]=0.4
someData$p[someData$p>0.8]=0.8
ggplot(someData) +
  geom_brain(atlas = dk, 
             position = position_brain(hemi ~ side),
             aes(fill = p)) +
  scale_fill_distiller(palette = "RdBu"
                       , limits = c(0.4, 0.8))+
  #viridis::scale_fill_viridis(option = 'magma',limits=c(0.4, 0.8 ))+
  #scale_fill_gradient(brewer.pal(n = 2, name = "Reds")) +
  # scale_fill_gradient2(low="white", mid="#EC352F", high="#6C1917", 
  #                      midpoint=0.6,   
  #                      limits=c(0.4, 0.8 ))+
  theme_void() +
  labs(title = "High Gamma")
#> merging atlas and data by 'region'
ggsave('~/Desktop/figure_DRAFTS/new_topo/ICC_HighGamma_rb', device = "pdf")





