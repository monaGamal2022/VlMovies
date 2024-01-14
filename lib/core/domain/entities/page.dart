class Page<T> {
  final List<T> data;
  int page;
  bool isLastPage;

  Page({
    required this.data,
    this.page = 1,
    this.isLastPage = false,
  });
}
