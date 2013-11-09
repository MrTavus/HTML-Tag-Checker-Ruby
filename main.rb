def htmlTagChecker(fileName)
  
  htmlContent  = File.read(fileName)
 
  allTags = []
  startTags = []
  finishTags = []
  first_index = 0
  last_index  = 0

  for i in 0..htmlContent.length
     char = htmlContent[i]

     if char == "<"
          first_index = i
     end
     if char == ">"
         last_index = i-first_index+1
         allTags.push(htmlContent[first_index,last_index])

      if(htmlContent[first_index+1] == "/")
        finishTags.push(htmlContent[first_index,last_index])
      else
        startTags.push(htmlContent[first_index,last_index])
      end

     end
  end
  
  puts "Dosya icerisinde bulunan tum HTML taglari : "
  writeTags(allTags)
  
  puts ""
  puts "HTML tag esleme sonucu : "
  tagCheckerStatus = tagControl(startTags,finishTags)
  if tagCheckerStatus
    puts "HTML taglari dogru eslesmis"
  else
    puts "HTML taglari hatalidir."
  end
  
end

def writeTags(tags)
  
  for i in 0..tags.length
    puts tags[i]    
  end
end

def tagControl(startTags,finishTags)
  
  
  if startTags.length != finishTags.length
    return false
  end
  
  
  for i in 0..startTags.length-1
    
    sTag = startTags[i]
    sTag = sTag.to_s.split(//)
    sTag.shift
    startTagStr = sTag.join('')
    
    if !finishTags.empty?
        for j in 0..finishTags.length-1
          fTag = finishTags[j]
          fTag = fTag.to_s.split(//)
          fTag.shift(2)
          finishTagStr = fTag.join('')
          
          if startTagStr == finishTagStr
            
              finishTags.delete_at(j)
              break;
          end
        end
    else 
       return false
    end    
  end
  
  
  if finishTags.empty?
    return true
  else
    return false
  end
end
  
/HTML CHECKER ISLEMINI BASLATIYORUZ/
htmlFileName = "index.html"
htmlTagChecker(htmlFileName)
