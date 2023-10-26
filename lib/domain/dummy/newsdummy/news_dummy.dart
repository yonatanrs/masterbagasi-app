import '../../entity/news/news.dart';

class NewsDummy {
  NewsDummy();

  News generateShimmerDummy() {
    return News(
      id: "",
      title: "",
      slug: "",
      thumbnail: "",
      body: "",
      status: ""
    );
  }

  News generateDefaultDummy() {
    return News(
      id: "",
      title: "",
      slug: "",
      thumbnail: "",
      body: "",
      status: ""
    );
  }
}