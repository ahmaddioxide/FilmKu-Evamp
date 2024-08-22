class ProcessImage {
  static String processImageLink(link) {
    if (link == null) {
      return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9dB5ERe0v9QUXux7rr6TnHW9nNlvmZpWqqA&s';
    }

    return 'https://image.tmdb.org/t/p/w500$link'.toString();
  }

  static String processPosterLink(link) {
    if (link == null) {
      return 'https://png.pngtree.com/png-vector/20190816/ourlarge/pngtree-film-logo-design-template-vector-isolated-illustration-png-image_1693431.jpg';
    }

    return 'https://image.tmdb.org/t/p/original$link';
  }
}
