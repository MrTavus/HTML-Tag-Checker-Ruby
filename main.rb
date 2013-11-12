def htmlTagChecker(fileName)
  
  htmlContent  = File.read(fileName)
 
  allTags = []
  tags = []
  first_index = 0
  last_index  = 0
  durum = true
  
  i=0;
  
  while durum == true and i<=htmlContent.length
    
    char = htmlContent[i]

    /Karsilasilan karakter < ise bir tag baslangicidir ve 
    < karakterinin sirasini bir degiskene atiyoruz/
     if char == "<"
          first_index = i
     end
     /Eger karsilasilan karakter > ise bir tag kapatmadir
     ve if icerisindeki islemlere giriyoruz/
     if char == ">"
        /Kapatma taginin oldugu yerin sirasini degiskene atiyoruz /
        last_index = i-first_index+1
         
         /Tum taglari allTags listesine ekiyoruz.
         Program sonunda bulunan tum taglari yazdirmak icin kullanacagiz/
         allTags.push(htmlContent[first_index,last_index])
        
      
      /Eger tag icerisinde \/ isareti varsa bir kapatma tagidir ve ona gore isleme devam ediyoruz/
      if(htmlContent[first_index+1] == "/")
        /Eger tags listesinde baslama tagi bulunamaz ama yeni bir kapatma tagi ile karsilasilirsa 
        "else" icerisine ama tags'da baslama tagi varsa if ifadesine giriyoruz/
        if !tags.empty?
           
          /Baslangic taglarini string ifade haline getiriyoruz ve basindaki "<" ifadesini kaldiriyoruz/
          sTag = tags.last()
          sTag = sTag.to_s.split(//)
          sTag.shift(1)
          startTagStr = sTag.join('')
        
          /Bitirme taglarini string ifade haline getiriyoruz ve basindaki <\/ ifadesini kaldiriyoruz/
          fTag = htmlContent[first_index,last_index]
          fTag = fTag.to_s.split(//)
          fTag.shift(2)
          finishTagStr = fTag.join('')
          
          /Son eklenen baslama tagini karsilasilan bitirme tagi ile karsilastiriyoruz. 
          Eger ayni ise listeye eklenen baslangic tagini listeden kaldiriyoruz
          Eger esit degilse durumu false yapiyoruz ve donguden cikiyoruz/
          if startTagStr == finishTagStr
            tags.pop()
          else
            durum = false            
          end
          
        /Tag listesinde baslangic tagi kalmadi ama bitis tagi ile karsilasildi ise 
        durumu 0 yapiyoruz ve while'dan cikiyoruz/
        else
          durum = false
        end
      /Tag icerisinde \/ isareti yoksa baslama tagidir ve taglar listesinin sonuna ekliyoruz/
      else
        tags.push(htmlContent[first_index,last_index])
      end
    end
    i += 1
  end
  
  puts "Dosya icerisinde bulunan tum HTML taglari : "
  writeTags(allTags)
  
  puts ""
  puts "HTML tag esleme sonucu : "
  
  if durum
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
  
/HTML CHECKER ISLEMINI BASLATIYORUZ/
htmlFileName = "index.html"
htmlTagChecker(htmlFileName)
