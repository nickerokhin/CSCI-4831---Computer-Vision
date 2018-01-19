                %{
                if col <= kernel_overlap
                    colLimit = floor(kernel_size/col/2)
                    ykernStart = 1  + colLimit
                    ykernEnd = kernel_size
                    
                elseif col >= ySize - kernel_overlap
                    colLimit = -floor(kernel_size/col/2)
                    ykernStart = 1
                    yKernEnd = kernel_size - colLimit
                    
                else
                    colLimit = 0
                    ykernStart = 1
                    ykernEnd = kernel_size
                end
                
                if row <= kernel_overlap
                    rowLimit = floor(kernel_size/row/2)
                    xkernStart = 1 + colLimit
                    xkernEnd = kernel_size
                    
                elseif row >= xSize - kernel_overlap
                    rowLimit = -floor(kernel_size/row/2)
                    xkernStart = 1
                    xkernEnd = kernel_size - rowLimit
                    
                else
                    rowLimit = 0
                    xkernStart = 1
                    xkernEnd = kernel_size
                end

                kernSum = 0
                
                if colLimit ~= 0
                    if colLimit > 0
                        %start at row,col pixel
                        colRangeS
                    end
                end
                
                if rowLimit ~= 0
                    imgXbuff = 
                end
                    
                    
                  
                for kernX = xkernStart:xkernEnd + rowLimit
                    
                    for kernY = ykernStart:ykernEnd
                        kernSum = kernSum + kernel(kernX, kernY) *   
                        
                    end
                end
                %}