1. 8253 ya da 8254 ile notaları verilen müzik parçası çalınacaktır. İsteyen farklı bir müzik parçası çalabilir. Ancak yapacağı deneyde çalacağı müzik parçasını belirtmeli ve paylaşılan müzik.xlsx dosyasındaki formatta bir dosya hazırlayıp göndereceği lab klasörüne eklemelidir.
2. 8253 ve 8254 entegreleri pin konfigürasyonu bakımından aynıdır. 8254 entegresi 8253’ün gelişmiş sürümüdür.
3. I/O uzayında 8253 A9H adresinden başlayarak ardışık tek adreslerde yer alacaktır.
4. 8253’ün CLK ucuna 240 kHz sıklığında (frekansında) bir kare sinyal üreteci bağlanacaktır.
5. 8253’ler için Counter Latch ve Read Back komutları simülasyonda çalışmamaktadır. Sayıcı
durumu kontrol edilmek istendiğinde çıktı (OUT ucu) bir 8255’e bağlanabilir.
6. OUT çıkışı speaker’a bağlanacaktır.
7. DATA segmentte NOTALAR, SURELER adlı iki dizi ve NOTASAYISI adlı bir değişken
tanımlanacaktır.
8. Bu diziler, verilen müzik parçasına ait notaları ve bu notaların kaç birim zaman çalınacağını
gösterecek biçimde hazırlanacaktır.
9. LOOP komutu kullanılarak en az 2FFFH adım boş döngü içeren, NEAR tipinde bir DELAY
prosedürü yazılacaktır.
10. Verilen müzik parçasını (verilen notalarda ve sürelerde) COUNTER 0 yardımıyla ana yordamda
tekrarlı olarak çalan Assembly kodu yazılacaktır.
11. Birim nota çalma süresi olarak DELAY işlevi (fonksiyonu) kullanılacaktır.

NOT: pdsprj uzantılı devre dosyasında assembly kodu da yer almaktadır ama ayrı bir dosya olarak da kodu ekledim.

<img width="1238" alt="Ekran Resmi 2023-01-24 12 34 58" src="https://user-images.githubusercontent.com/83477882/214258036-f0ea3ce6-3e95-4319-b91c-9e47ef2c6bea.png">
