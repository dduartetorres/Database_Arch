db = db.getSiblingDB('libraryhub');
db.books.createIndex({category:1});
db.books.createIndex({author:1});
db.books.insertMany([
 {_id:'BOOK-001',isbn:'9780000000011',title:'Distributed Systems in Practice',author:'Marta Silva',publisher:'Tech Press',year:2024,category:'Technical',description:'A practical guide to distributed databases and event-driven systems.',attributes:{programming_language:'Python',difficulty:'Intermediate'},keywords:['databases','distributed','kafka']},
 {_id:'BOOK-002',isbn:'9780000000028',title:'SQL Fundamentals',author:'Rui Costa',publisher:'Data House',year:2023,category:'Technical',description:'Relational modelling, SQL queries, indexes and transactions.',attributes:{programming_language:'SQL',difficulty:'Beginner'},keywords:['sql','relational']},
 {_id:'BOOK-003',isbn:'9780000000035',title:'The Island of Stories',author:'Lina Martins',publisher:'Young Readers',year:2020,category:'Fiction',description:'An imaginative fantasy adventure.',attributes:{genre:'Fantasy',recommended_age:12},keywords:['fiction','adventure']},
 {_id:'BOOK-004',isbn:'9780000000042',title:'Learning for Children',author:'Sara Lopes',publisher:'Family Books',year:2022,category:'Children',description:'Curious lessons and stories for young readers.',attributes:{recommended_age:8},keywords:['children','learning']}
]);
