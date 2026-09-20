use libraryhub;
// G1
db.books.findOne({_id:'BOOK-001'});
// G2: flexible category-specific attributes
db.books.find({category:'Technical','attributes.programming_language':'SQL'});
// G3
db.books.find({author:/Silva/i},{title:1,author:1,category:1});
