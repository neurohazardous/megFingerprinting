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

