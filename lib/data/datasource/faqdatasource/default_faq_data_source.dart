import 'package:dio/dio.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';

import '../../../domain/entity/faq/faq.dart';
import '../../../domain/entity/faq/faq_list_parameter.dart';
import '../../../misc/constant.dart';
import '../../../misc/multi_language_string.dart';
import '../../../misc/processing/dummy_future_processing.dart';
import '../../../misc/processing/future_processing.dart';
import 'faq_data_source.dart';

class DefaultFaqDataSource implements FaqDataSource {
  final Dio dio;

  DefaultFaqDataSource({
    required this.dio
  });

  @override
  FutureProcessing<List<Faq>> faqList(FaqListParameter faqListParameter) {
    return DummyFutureProcessing((parameter) async {
      return <Faq>[
        Faq(
          id: "1",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "What is Master Bagasi?",
            Constant.textInIdLanguageKey: "Apa itu Master Bagasi?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: """Master Bagasi adalah e-commerce pertama karya anak bangsa yang menyediakan produk-produk asli buatan Indonesia untuk di-supply ke mancanegara. Melalui 3 layanan utamanya yaitu Marketplace, On-Demand Services, dan Logistic, kami membantu meng-etalase-kan produk-produk tersebut dan mengirimkannya ke seluruh penjuru dunia dengan harga terjangkau, proses yang mudah, dan pengiriman yang cepat."""
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "2",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "How does Master Bagasi work?",
            Constant.textInIdLanguageKey: "Bagaimana Cara kerja Master Bagasi?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: """Cara kerja kami sangat lah sederhana, yaitu:<ol><li>Anda bisa langsung memilih produk yang anda inginkan pada etalase Master Bagasi, lalu hubungi Tim Komunikasi kami untuk konfirmasi terkait ketersediannya. Jika produk yang anda inginkan tidak tersedia, beri catatan pada tim Komunikasi kami agar dibantu untuk dicarikan sesuai dengan yang anda inginkan, dan atau jika anda memiliki barang atau paket yang siap dikirimkan, silahkan antar paket/barang tersebut ke alamat kami.</li><li>Setelah barang yang anda inginkan lengkap, Tim Warehouse kami akan melakukan packing terhadap barang anda dengan sangat rapi dan teliti sehingga dapat meminimalisir kerusakan dalam proses pengiriman nantinya.</li><li>Setelah barang anda siap untuk dikirim, Tim Office kami akan membuatkan anda AWB pengiriman dan barang pun kami serahkan kepada mitra logistik kami yang terpercaya, barang pun terbang ke negara tujuan anda aman.</li>Setelah barang sampai di negara tujuan, terdapat kemungkinan barang diperiksa oleh pihak custom setempat. Selama proses ini, mitra logistik kami akan membantu proses custom clearance hingga selesai dan mengantarkan barang anda sampai tepat di depan pintu rumah anda.<li>Dengan mengusung slogan "Bringing Happiness Into Your Table", Master Bagasi akan selalu berusaha memberikan pelayanan terbaik kepada anda, karena kebahagiaan anda adalah tujuan kami berkarya.</li></ol>"""
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "3",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "What Items Cannot Be Sent?",
            Constant.textInIdLanguageKey: "Barang Apa Saja Yang Tidak Bisa Dikirim?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Barang-barang terlarang seperti Senjata Tajam, Narkotika, Alkohol, dan Sejenisnya. Kemudian barang-barang pecah belah maupun barang dengan tingkat keawetan rendah tidak disarankan untuk dikirim. Karena Master Bagasi tidak bertanggung jawab atas kerusakan terkait pengiriman tersebut."
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "4",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "What Payment Methods Are Available?",
            Constant.textInIdLanguageKey: "Metode Pembayaran Apa Saja Yang Tersedia?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Anda bisa membayar melalui Transfer Bank, PayPal, Wise, dan pembayaran lainya yang telah terlebih dahulu disepakati bersama."
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "5",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "How long is the shipping process?",
            Constant.textInIdLanguageKey: "Berapa Lama Proses Pengirimannya?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Estimasi pengiriman adalah 3 sampai 7 hari kerja terhitung sejak barang dikirim. Lama waktu pengiriman sangat mungkin lebih cepat atau lebih lambat, tergantung keadaan atau kondisi tertentu pada saat pengiriman ke negara destinasi. Diantara kondisi tertentu tersebut adalah faktor cuaca, faktor gangguang penerbangan, faktor custom clearance, dan sebagainya."
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "6",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "Is the Price All-Inclusive?",
            Constant.textInIdLanguageKey: "Apakah Harga Sudah All-In?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Harga yang di berikan di luar pajak di negara tujuan. Regulasi dan kondisi di setiap negara berbeda beda. Adapun untuk pemberitahuan perihal pajak akan di informasikan secara langsung melalui e-mail anda oleh mitra logistik terkait atau dibantu oleh Tim Komunikasi kami."
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "7",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "How to Calculate Cardboard Volume?",
            Constant.textInIdLanguageKey: "Bagaimana Cara Menghitung Volume Kardus?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Rumus menghitung volume kardus adalah Panjang x Lebar x Tinggi dibagi 5.000. Jika hasil volume kardus lebih besar dari berat barang maka yang menjadi tolak ukur adalah angka tertinggi di antara keduanya."
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "8",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "Is There a Minimum Delivery?",
            Constant.textInIdLanguageKey: "Apakah Ada Minimal Pengiriman?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Minimal pengiriman adalah 1 kilogram. Untuk barang dengan berat di bawah 1 kilogram akan tetap terhitung 1 kilogram. Berlaku untuk setiap jenis barang lain nya."
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "9",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "How Much Is It To Send Items In Master Bagasi?",
            Constant.textInIdLanguageKey: "Berapa Harga Untuk Mengirim Barang Di Master Bagasi?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: """Untuk informasi mengenai biaya pengiriman, bisa didapatkan melalui website kami di <a href="https://masterbagasi.com/cargo">https://masterbagasi.com/cargo</a> atau bisa berkonsultasi langsung melalui Tim Komunikasi kami langsung melalui <a href="https://masterbagasi.com/contactus">https://masterbagasi.com/contactus</a> untuk informasi lebih lanjut."""
          }).toEmptyStringNonNull
        ),
        Faq(
          id: "10",
          title: MultiLanguageString({
            Constant.textEnUsLanguageKey: "How to Track My Parcel?",
            Constant.textInIdLanguageKey: "Bagaimana Melacak Paket Saya?"
          }).toEmptyStringNonNull,
          content: MultiLanguageString({
            Constant.textEnUsLanguageKey: "(No Content)",
            Constant.textInIdLanguageKey: "Setelah pembayaran dilakukan, Tim Komunikasi kami akan memberikan nomor AWB pengiriman yang nantinya bisa digunakan untuk melacak paket anda. Tapi tenang, tanpa anda minta, Tim Komunikasi kami juga akan secara rutin menginformasikan perihal posisi paket anda setiap harinya."
          }).toEmptyStringNonNull
        )
      ];
    });
  }
}