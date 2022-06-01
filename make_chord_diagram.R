
# setup workspace
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memrory and report the memory usage.
library(circlize)
circos.clear()

# setup filenames
cog = 5

i = sprintf("S%sp.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/S%sp.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'red', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()


i = sprintf("S%sn.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/S%sn.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'blue', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()





i = sprintf("JS%sp.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/JS%sp.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'red', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
          "Default Mode" = "#d9717c", 
          "Dorsal Attention" = "#409832",
          "Frontoparietal" = "#f0b944", 
          "Limbic" = "#f6fdc9", 
          "Ventral Attention" = "#e065fe", 
          "Somatomotor" = "#789ac0",
          "Subcortical" = "#ce4456",
          "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()


i = sprintf("JS%sn.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/JS%sn.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'blue', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()

i = sprintf("JF%sp.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/JF%sp.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'red', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()


i = sprintf("JF%sn.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/JF%sn.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'blue', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()

i = sprintf("F%sp.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/F%sp.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'red', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()


i = sprintf("F%sn.jpg", cog)
f = sprintf("/Users/user/Dropbox (The University of Manchester)/Amending_jPCA/3rd revision/bic/mdls_pred_conn/individualdiffs/F%sn.csv", cog)
jpeg(filename=i, width=1000, height=1000, res=200)

# reading file
mat1 = read.csv(f, header=FALSE)
mat1 = as.matrix(mat1)

# setting up names of networks (diagram sectors)
names =  read.csv("/Users/user/yeo7nets/yeo_7_names.csv",header=FALSE)
row.names(mat1) <- names$V1
colnames(mat1) <- names$V1

# colors for links (change red or blue):
col_mat = rand_color(length(mat1), transparency = 0.4, hue = 'blue', luminosity = 'bright')

# colors for sectors
dim(col_mat) = dim(mat1)
net_color = c("Cerebellum" = "#b15928",
              "Default Mode" = "#d9717c", 
              "Dorsal Attention" = "#409832",
              "Frontoparietal" = "#f0b944", 
              "Limbic" = "#f6fdc9", 
              "Ventral Attention" = "#e065fe", 
              "Somatomotor" = "#789ac0",
              "Subcortical" = "#ce4456",
              "Visual" = "#a251ad")

# plotting
plot.new()
par(cex = 0.9, mar = c(0.5, 0.5, 0.5, 0.5))

circos.par(canvas.xlim = c(-1.4, 1.4), canvas.ylim = c(-1.4, 1.4))
chordDiagram(mat1, annotationTrack = "grid", 
             preAllocateTracks = 1, self.link = 1, keep.diagonal = TRUE,symmetric = TRUE,
             grid.col = net_color, col = col_mat,order = names(sort(mat1)), big.gap = 1)

# setting up labels of sectors
circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
  xlim = get.cell.meta.data("xlim")
  ylim = get.cell.meta.data("ylim")
  sector.name = get.cell.meta.data("sector.index")
  circos.text(CELL_META$xcenter, 
              ylim[1] + cm_h(2), 
              sector.name, 
              facing = "clockwise",
              niceFacing = TRUE, 
              adj = c(0, 0.5),
              cex = 0.9,
              col="black",
              font = 1)
  circos.axis(h = "bottom",
              labels.cex = .6,
              sector.index = sector.name
  )
}, bg.border = NA)

dev.off()

circos.clear()