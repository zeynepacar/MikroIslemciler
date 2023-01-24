1. 8251 PÇA (Programlanabilir Çevre Arayüzü) ve 8259A (Programlanabilir Kesme Denetleyicisi) kullanarak seri olarak gelen veriyi kesme mantığı ile okuyup cevap veren bir program yazılması istenmektedir.
2. Bunun için seri veri almaya ilişkin kesme alt programını kesme vektör tablosunun 78H numaralı gözüne, seri veri göndermeye ilişkin kesme alt programını ise kesme vektör tablosunun 79H numaralı gözüne yerleştiriniz.
3. 8259A'yı ve 8251'i kesme kullanımıyla ilgili olarak uygun şekilde ayarlayınız (kesmelerin kenar tetikleme olmasını sağlayınız).
4. Yazılacak seri veri alma kesme alt programı sanal terminalden gelen ASCII karakterlerin değerce bir büyüğünü bir dizide saklamalı, alınan veri adeti 5'e ulaştığında dizinin tüm elemanları kesme mantığı ile geri gönderilmeli.
5. Örneğin sanal terminalde sırasıyla 'a', 'b' 'c', 'd', 'e' karakterleri basılmışsa 'e' karakterinden sonra 8086 cevap olarak 'bcdef' göndermeli.
6. Sanal terminali 9600 baud, 8 data biti, paritisiz ayarlayınız.
7. 8251'de veri okurken IN AL,DATA_ADDR komutundan sonra SHR AL,1
komutunu çalıştırınız. Aksi takdirde benzetim ortamı modelinden kaynaklanan bir hata ile karşılaşılabilir.

NOT: pdsprj uzantılı devre dosyasında assembly kodu da yer almaktadır ama ayrı bir dosya olarak da kodu ekledim.

<img width="1223" alt="Ekran Resmi 2023-01-24 12 05 54" src="https://user-images.githubusercontent.com/83477882/214252097-b13f5513-3b50-4d22-a285-cef7afd98dec.png">
