//
//  MF3.swift
//  AlgorithmsSwift
//
//  Created by Michael Ho on 11/3/20.
//

class MF3 {
    /**
     The content in this lecture is about the application of max flow min cut algorithm - image segmentation.
     Given an image with pixels that can be categorized in foreground and background. Converted to a
     graoh, each pixel can be represented by a vertex/node in the graph. Besides, we need to add two extra
     vertices/nodes to the graph, one represents foreground (F) while the other represents background (B).
     
     Each pixel in the graph has different weight depending on its foreground-background distribution.
     Therefore, there are edges from F and B with different weights linking to each pixel vertices. The weight
     of which are determined by how the pixel is distributed in foreground and background. In addition, there are
     bi-directional edges between each neighbor pixels. The weights of which are determined by smoothness term.
     
     After the graph conversion is done, we can use the method in max flow min cut algorithm in MF2 to find the min cut
     in the graph. Those edges will be used to cut the foreground image from its background.
     
     Reference: http://www.cs.ucf.edu/~bagci/teaching/computervision16/Lec13.pdf
     P.S. I haven't found an illustrative example for this algorithm, please feel free to contribute.
     */
    func imageSegmentation(_ image: [[Int]]) -> Set<[Int]> {
        // Step 1: Convert the image to a graph with flow network.
        // Step 2: Perform max flow min cut algorithm on the graph.
        // Step 3: Use DFS to find the min cut edges.
        return Set<[Int]>()
    }
}
