enum UserGender {
  FEMALE,
  MALE,
  OTHER,
}

enum PostStatus {
  OPENED,
  CLOSED,
}

enum BookType {
  RecommendBook,
  HighestRateBook,
  MostReviewBook,
}

enum PostType {
  Owned,
  BasedOnBook,
  Feed,
}

enum ReviewType {
  Owned,
  BasedOnBook,
}

const kLimitCodeLocation = {
  "city": 100,
  "district": 1000,
  "ward": 100000,
};
