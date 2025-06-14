# 1. What is PostgreSQL?
PostgreSQL হলো একটি জনপ্রিয় ডাটাবেস ম্যানেজমেন্ট সিস্টেম। এটাকে ORDBMS: Object-Relational Database Management System ও বলা হয়ে থাকে। ORDBMS এর মানে হচ্ছে এটি Relational Database Management System এর কনসেপ্ট সাপোর্ট করার পাশাপাশি  Object Oriented প্রোগ্রামিং এর কনসেপ্ট নিয়ে কাজ করার মতো ফীচারকে এক্সটেন্ড করে।  এর জন্য এর জনপ্রিয়তা অনেক বেশি। এটি PostgreSQL Global Development Group এর ডেভেলপেড করে করে ১৯৮৯ সালে এবং পরবর্তীতে এটি ওপেন-সোর্স হিসেবে রিলিস করা হয়। এর উল্লেখযোগ্য ফিটারগুলু হলো :

1. এটি SQL এর সাথে পুরোপুরিভাবে কাজ করতে সমর্থ।  যেমন: ACID(Atomicity, Consistency, Isolation, Durability), Joins, subqueries, complex operations, Transactions(BEGIN, COMMIT, and ROLLBACK) কার্যকরভাবে সম্পাদন করে থাকে। 

2. এর রয়েছে সমৃদ্ধ বিল্ট-ইন ডাটা টাইপ। তাদের মধ্যে  Numeric, Character, Date/Time, Boolean, JSON/JSONB, UUID, XML, arrays, (key-value pairs), geometric উল্লেখযোগ্য।

3. এর  খুব ভালো Extensibility রয়েছে। যেমন : এটি SQL, PL/pgSQL বা  Python, Perl ইত্যাদি ল্যাঙ্গুয়েজে লিখা কাস্টম ফাঙ্কশন এর সাথে কাজ করতে পারে, কাস্টম ডাটাটাইপ ও অপারেটর এর সাথেও ভালোভাবে তালমিলাতে পারে।

4. এর রয়েছে B-tree, Hash, GiST, GIN, SP-GiST, BRIN এর মতো অ্যাডভান্স ইনডেক্স টেকনিক সাপোর্টিং সক্ষমতা।  

5. এটি Multi-Version Concurrency Control ব্যবহার এর মাদ্ধমে একেই সাথে মাল্টিপল ট্রানসাকশান এর অনুমতি দেয় এবং এই ক্ষেত্রে উচ্চ কার্যক্ষমতা প্রদর্শন করে। 

6. এটি একইসাথে ছোট এবং এন্টারপ্রাইস লেভেলের এপ্লিকেশনে ভালো পারফরমেন্স প্রদর্শন করে।  Web applications, Geospatial applications , Financial systems, Federated and distributed ডাটাবেসে সকল ক্ষেত্রেই এর সুনাম রয়েছে। ডাটা এনালাইসিস এর ক্ষেত্রে কিছু গুরুত্বপূর্ণ ফীচার এর জন্য অন্য RDBMS থেকে এটির জনপ্রিয়তা অধিক।

# 2. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

PostgreSQL সহ সকল রিলেশনাল ডাটাবেস ম্যানেজমেন্ট সিস্টেম এর জন্য Primary  key  এবং Foreign Key খুবই গুরুত্বপূর্ণ কনসেপ্ট। ডাটাবেসের টেবিলগুলোর ম্যানেজমেন্ট এদের ওপরেই বহুলাংশে  নির্ভর করে।  চলেন এদের সম্পকে বিস্তারিত আলোচনা করি.

### Primary Key: 
একটি টেবিল এর  প্রতিটি রেকর্ড বা রো কে ইউনিকভাবে  উপস্থাপন করার জন্য ব্যবহৃত এক বা একাধিক কালামের ডাটার সেটাকে বলা হয় Primary  key ।  এই সেট এর ভ্যালু বা ভ্যালুগুলোর কম্বিনেশন প্রতিটি রো এর জন্য ইউনিক হতে হবে এবং এই সেট কখনো Null হতে পারবে না এগুলো হচ্ছে Primary  key হওয়ার শর্ত।
| Name       | Roll No | Marks |
|------------|---------|-------|
| Alice      | 101     | 88    |
| Bob        | 102     | 76    |
| Charlie    | 103     | 92    |
| Diana      | 104     | 81    |
| Alice      | 105     | 69    |
| Fiona      | 106     | 95    |
| George     | 107     | 73    |

এই টেবিলে আমরা রোল নম্বর দিয়ে চাইলে প্রতিজ্ঞ স্টুডেন্টকে আইডেন্টিফাই করতে পারি। তাই এখানে রোল নম্বর column টা প্রাইমারি কী হিসেবে কাজ করছে।
| Name     | Roll No | Class | Marks |
|----------|---------|-------|-------|
| Alice    | 101     | 10   | 88    |
| Bob      | 101     | 9    | 76    |
| Charlie  | 101     | 8   | 92    |
| Alice    | 104     | 10   | 81    |
| Ethan    | 105     | 10  | 69    |
| Alice    | 106     | 10  | 95    |
| George   | 107     | 10   | 73    |

কিন্তু এই টেবিলে আমরা name , roll no , class এবং marks কোনো একটি কলাম দিয়েই ইউনিকভাবে আমরা একটি রোকে প্রেসেন্ট করতে পারবো না।  কিন্তু এখানে যদি আমরা Roll No + Class এই দুইটাকে একসাথে করে চিন্তা করি তাহলে ইউনিকভাবে করা সেটা পসিবল।  এক্ষেত্রে Roll No, Class  এই দুই কলাম এর ভ্যালুর সমন্বয়ে যেই সেট ক্রিয়েট হচ্ছে সেটাই  হচ্ছে এখানের  প্রাইমারি কী। 

### Foreign key
**Result Table**
| Roll No | Name     |   Course_ID      | Passed |
|---------|----------|------------------|--------|
| 101     | Alice    | CSE101           | true   |
| 102     | Bob      | CSE102           | false  |
| 103     | Charlie  | CSE103           | true   |
| 104     | Diana    | CSE101           | false  |
| 105     | Ethan    | CSE104           | true   |
| 106     | Fiona    | CSE102           | true   |
| 107     | George   | CSE105           | false  |


**Course Table**
| Course_ID | Course Name           |
|-----------|------------------------|
| CSE101    | Introduction to CS     |
| CSE102    | Data Structures        |
| CSE103    | Algorithms             |
| CSE104    | Operating Systems      |
| CSE105    | Computer Networks      |

এখানে দেয়া Result Table  এবং Course  Table  থেকে যদি আমরা জানতে চাই কোনো একজন স্পেসিফিসি স্টুডেন্ট কোন কোন কোর্স এ পাস করেছে সেই কোর্স গুলুর নাম প্রেসেন্ট করতে  তাহলে আমাদের কোনো না কোনো ভাবে এই দুই টেবিল এর মধ্যে একটা  কানেকশন করতে হবে যেন course id দিয়ে course এর নাম খুঁজে বের করতে পারি। 
কারণ এখানে কোনো একটা সিঙ্গেল টেবিলে এই দুইটি ডাটা নেই। 
এখন Course টেবিল এর Course_Id কলামটি প্রাইমারি কীয় হিসেবে আছে।  এই সেইম ইনফরমেশন টা আবার Result টেবলেও Course_Id কলামে রয়েছে। এখন আমরা যদি Course_Id কালামের ভিত্তিতে দুইটি টেবিলের মধ্যে একটা রিলেশন এস্টাব্লিশড করি তাহলে তাহলে Course_Id টি রেজাল্ট টেবিলের জন্য ফরেই কী হিসেবে কাজ করবে। যদি আমরা ডেফিনেশন হিসেবে বলতে চাই তাহলে এভাবে বলা যায় যে, যদি কোনো টেবিলের একটি কলাম অন্য টেবিলের প্রাইমারি কী কে রেফারেন্স করে দুইটি টেবিলের মধ্যে একটি রেলশন ক্রিয়েট করে তাহলে সেই কালামকে ঐ টেবিলের Foreign Key বলে। এখানে Course_Id হলো Result টেবিলের  Foreign Key ।

# 3. What is the difference between the VARCHAR and CHAR data types?

CHAR,  VARCHAR হলো SQL এর প্রায় একই কিন্তু গুরুত্বপূর্ণ ২ টি আলাদা ডাটা টাইপ।  তারা উভয়েই কেরেক্টর টাইপের ডাটা অপেরেশনের কাজে ব্যবহৃত হয়। কিন্তু তাদের মধ্যে কিছু সামান্য পার্থক্য রয়েছে। নিচে এগুলো তুলে ধরা হলো :

### CHAR
এটি একটি ফিক্সড লেন্থের স্ট্রিং এর জন্য বিবৃত হয়। 
 ```sql 
 CREATE TABLE employee (
 id SERIAL  PRIMARY KEY,
 name CHAR(15)
);
```
যদি আমরা এই কমান্ডটি লিখি তাহলে যেই টেবিল টা  তৈরী হবে তার name কলাম এর জন্য ১৫ ক্যারেক্টার লেন্থের জন্য একটি ফিক্সড প্লেস তৈরী হবে নিচের মতো 
|   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

এখন যদি আমরা এখানে একটি ভেলু ইন্সার্ট করি 

```sql 
INSERT INTO employee (name) VALUES ('Mr. X');
```
তাহলে এটি এখানে মাত্র ৫ টি ক্যারেক্টার এর জায়গা নিবে  বাকি গুলো খালি পরে থাকবে একদম নিচের মতো 

|  M  |  r  |  . |   |  X  |   |   |   |   |   |   |   |   |   |   |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|


### VARCHAR
কিন্তু VARCHAR হলো ভ্যারিয়েবল লেথ এর মতো।  যদি আমরা নিচের মতো একটি কোড লিখি :
```sql 
 CREATE TABLE employee (
 id SERIAL  PRIMARY KEY,
 name VARCHAR(15)
);
```

তাহলে এই টেবিল এর name কলাম এর জন্য একটি ডাইনামিক জায়গা তৈরী হবে যার সর্বোচ্ছ ধারণ ক্ষমতা হলো ১৫ কেটেক্টের। কিন্তু কেউ যদি এখানে নিচের মতো ডাটা ইনপুট দেয় 
```sql 
INSERT INTO employee (name) VALUES ('Mr. X');
``` 
তাহলে এটি এই ইন্সার্ট ভ্যালুর জন্য ৫ ক্যারেক্টার এর জায়গা নিয়ে বাকি টুকু কে রিলিজ করে দিবে CHAR  এর মতো বাকিটুকুকে স্পেস দিয়ে পূর্ণ করে  রাখবে না

|  M  |  r  |  . |   |  X  | 
|---|---|---|---|---|

**CHAR ফিক্সড লেন্থ হওয়ায় ফিক্সড সাইজের ডাটার  ক্ষেত্রে এটির Storage Efficiency এবং Performance উভয়েই ভালো। কিন্তু ভারিবল লেন্থ ডাটার ক্ষেত্রে VARCHAR এর Storage  Efficiency এবং Performance বেটার।**

# 4. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

রিলেশনাল ডাটাবেসে প্রায় সময়েই  একাধিক টেবিলের ডাটাকে একসাথে উপস্থাপন এবং সেই একত্রিত ডাটার উপর প্রয়োজনীয় অপারেশন চালানোর প্রয়োজন পরে।  একধিক টেবিলের ডাটাকে একত্রে করার জন্য   Postgres সহ সকল RDBMS এই  JOIN ব্যৱহৃত হয়।  উদাহরণ স্বরূপ নিচে ২ টি টেবিল দেয়া হলো :

**Enrollment Table**
| Roll No | Name     | Course_ID |
|---------|----------|-----------|
| 101     | Alice    | CSE101    |
| 102     | Bob      | CSE102    |
| 103     | Charlie  | CSE103    |
| 104     | Diana    | CSE101    |
| 105     | Ethan    | CSE104    |
| 106     | Fiona    | CSE102    |
| 107     | George   | CSE105    |
| 108    | George   | NULL     |



**Course Table**
| Course_ID | Course Name           |
|-----------|------------------------|
| CSE101    | Introduction to CS     |
| CSE102    | Data Structures        |
| CSE103    | Algorithms             |
| CSE104    | Operating Systems      |
| CSE105    | Computer Networks      |
| CSE115    | Machine Learning    |

এখান থেকে যদি আমরা Roll No 104 যেই কোর্সে এনরোল করেছে তার নাম কি যদি জানতে চাই তাহলে আমরা কোনো সিঙ্গেল টেবিল এর ইনফরমেশন থেকে সেটা বলা পসিবলে না। কারন Enrollment Table এ রয়েছে স্টুডেন্ট এর কিছু ইনফরমেশন এবং কোর্স আইডি  কিন্তু আমাদের দরকার কোসের নাম যা কিনা রয়েছে Course Table এ। 
এরকম সিচুয়েশনে কাজ করার জন্যই JOIN ব্যবহৃত হয়.  Postgres মোটামোটি ৫-৬ ধরণের JOIN এর ব্যবহার দেখতে পাওয়া যায়: INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, CROSS JOIN . 

যেই Table গুলোকে  JOIN  করা হবে INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN এর জন্য সেই টেবিলগুলোর  মধ্যে কমপক্ষে একটি কলামের ভ্যালু আইডেন্টিকাল হতে হবে।  যেমন আমাদের ২ টা টেবিলের মধ্যে Course_ID আইডেন্টিকাল। কলামের নাম ভিন্ন হলেও সমস্যা নেই। JOIN করার SQL সিনটেক্সটি হলো :
```sql 
SELECT ___(যেই কলাম শো করতে চাই  তাদের নাম) 
FROM ___(প্রাইমারি টেবিলের নাম) 
___(কি ধরণের JOIN তার নাম)  ___ (জয়েন টেবিলের নাম)  
ON ___(প্রাইমারি টেবিলের আইডেন্টিকাল কলামের নাম)  = ___(জয়েন টেবিলের আইডেন্টিকাল কলামের নাম);
--CROSS JOIN এর জন্য উপরের শেষ লাইনটির দরকার নেই 
```

### INNER JOIN

এই ক্ষেত্রে ২ টি টেবিলের মধ্যে কমন ডাটা গুলোকেই  নতুন টেবিল এ অ্যাড করবে। আমাদের ওপরের ২ টি টেবিল এর জন্য INNER JOIN এর সিনটেক্স এবং আউটপুট টেবিল নিচের দেয়া হলো। এখানে Enrollment টেবিল থেকে Roll No 108 এবং Course টেবিল থেকে  CSE115 এর ডাটা বাদ পরে গেসে।
``` sql 
SELECT *
FROM Enrollment e
INNER JOIN Course c
ON e.Course_ID = c.Course_ID;
```
| Roll No | Name    | Course_ID | Course_ID | Course Name          |
|---------|---------|-----------|-----------|-----------------------|
| 101     | Alice   | CSE101    | CSE101    | Introduction to CS    |
| 102     | Bob     | CSE102    | CSE102    | Data Structures       |
| 103     | Charlie | CSE103    | CSE103    | Algorithms            |
| 104     | Diana   | CSE101    | CSE101    | Introduction to CS    |
| 105     | Ethan   | CSE104    | CSE104    | Operating Systems     |
| 106     | Fiona   | CSE102    | CSE102    | Data Structures       |
| 107     | George  | CSE105    | CSE105    | Computer Networks     |

### LEFT JOIN
এক্ষেত্রে প্রাইমারি টেবিলের (যেই টেবিলের নাম FROM এর পর পরেই লিখা হয় ) ডাটাকে প্রায়োরিটি দেয়া হওয়া হবে।  মানে প্রাইমারি টেবিলের সবগুলো ভেলুই নতুন টেবিলে আসবে কিন্তু তার রিলেটেড কোনো ডাটা যদি সেকেন্ডারি টেবিলে না থাকে তাহলে নতুন আউটপুট টেবিল এ সেই row গুলোর ভ্যালু NULL বসিয়েই দিবে। এর SQL query এবং আউটপুট নিচে দেয়া হলো :
``` sql 
SELECT *
FROM Enrollment e
LEFT JOIN Course c
ON e.Course_ID = c.Course_ID;
```

| Roll No | Name    | Course_ID | Course_ID | Course Name          |
|---------|---------|-----------|-----------|-----------------------|
| 101     | Alice   | CSE101    | CSE101    | Introduction to CS    |
| 102     | Bob     | CSE102    | CSE102    | Data Structures       |
| 103     | Charlie | CSE103    | CSE103    | Algorithms            |
| 104     | Diana   | CSE101    | CSE101    | Introduction to CS    |
| 105     | Ethan   | CSE104    | CSE104    | Operating Systems     |
| 106     | Fiona   | CSE102    | CSE102    | Data Structures       |
| 107     | George  | CSE105    | CSE105    | Computer Networks     |
| 108     | George  | NULL      | NULL      | NULL                  |

### RIGHT  JOIN
এক্ষেত্রে সেকেন্ডারি  টেবিলের (যেই টেবিলের নাম RIGHT JOIN এর পর পরেই লিখা হয় ) ডাটাকে প্রায়োরিটি দেয়া হওয়া হবে।  মানে সেকেন্ডারি  টেবিলের সবগুলো ভেলুই নতুন টেবিলে আসবে কিন্তু তার রিলেটেড কোনো ডাটা যদি প্রাইমারি টেবিলে না থাকে তাহলে নতুন আউটপুট টেবিল এ সেই row গুলোর ভ্যালু NULL বসিয়েই দিবে। এর SQL query এবং আউটপুট নিচে দেয়া হলো :
``` sql 
SELECT *
FROM Enrollment e
RIGHT JOIN Course c
ON e.Course_ID = c.Course_ID;
```

| Roll No | Name    | Course_ID | Course_ID | Course Name           |
|---------|---------|-----------|-----------|------------------------|
| 101     | Alice   | CSE101    | CSE101    | Introduction to CS     |
| 102     | Bob     | CSE102    | CSE102    | Data Structures        |
| 103     | Charlie | CSE103    | CSE103    | Algorithms             |
| 104     | Diana   | CSE101    | CSE101    | Introduction to CS     |
| 105     | Ethan   | CSE104    | CSE104    | Operating Systems      |
| 106     | Fiona   | CSE102    | CSE102    | Data Structures        |
| 107     | George  | CSE105    | CSE105    | Computer Networks      |
| NULL    | NULL    | NULL      | CSE115    | Machine Learning       |


### FULL  JOIN
এক্ষেত্রে উভয়   টেবিলের  ডাটাকে প্রায়োরিটি দেয়া হওয়া হবে।  মানে 
দুই টেবিলের ডাটাই আউটপুট টেবিলে থাকবে কিন্তু দুই টেবিলের কানেক্টেড না এমন রও গুলোর ভ্যালু  NULL বসিয়েই দিবে। এর SQL query এবং আউটপুট নিচে দেয়া হলো :
``` sql 
SELECT *
FROM Enrollment e
FULL OUTER JOIN Course c
ON e.Course_ID = c.Course_ID;

```
| Roll No | Name    | Course_ID | Course_ID | Course Name           |
|---------|---------|-----------|-----------|------------------------|
| 101     | Alice   | CSE101    | CSE101    | Introduction to CS     |
| 102     | Bob     | CSE102    | CSE102    | Data Structures        |
| 103     | Charlie | CSE103    | CSE103    | Algorithms             |
| 104     | Diana   | CSE101    | CSE101    | Introduction to CS     |
| 105     | Ethan   | CSE104    | CSE104    | Operating Systems      |
| 106     | Fiona   | CSE102    | CSE102    | Data Structures        |
| 107     | George  | CSE105    | CSE105    | Computer Networks      |
| 108     | George  | NULL      | NULL      | NULL                   |
| NULL    | NULL    | NULL      | CSE115    | Machine Learning       |


# 5. What are the LIMIT and OFFSET clauses used for? 

LIMIT এবং OFFSET এই দুইটি clause এর ব্যবহার ইন্টারেষ্টিং। এই ২ টি clause সাধারণত একটি কুয়েরি থেকে প্রাপ্ত আউটপুট row সংখ্যাকে কন্ট্রোলের কাজে ব্যবহৃত হয়।  চলেন নিচের এই সম্পর্কে বিস্তারিত আলোচনা করি :

### LIMIT
এই clause টি নির্দেশ করে একটি querry থেকে প্রাপ্ত row গুলো থেকে নির্দিষ্ট কতগুলো row কে রিটার্ন করবে তার সংখ্যা। এটি লিখার সিনটেক্স হচ্ছে :
SELECT কলামের নাম 
FROM টেবিলের নাম 
LIMIT কতগুলো row  রিটার্ন করবে তার সংখ্যা;
 
এক্সপেরিমেন্ট এর জন্য আমরা Enrollment নামের নিচের টেবিল টিকে নেই :
| Roll No | Name     | Course_ID |
|---------|----------|-----------|
| 101     | Alice    | CSE101    |
| 102     | Bob      | CSE102    |
| 103     | Charlie  | CSE103    |
| 104     | Diana    | CSE101    |
| 105     | Ethan    | CSE104    |
| 106     | Fiona    | CSE102    |
| 107     | George   | CSE105    |
| 108     | George   | NULL      |
  
 এই টেবিলের  LIMIT clause এর জন্য  SQL  কুয়েরি লিখি:
``` sql 
SELECT * FROM Enrollment
LIMIT 3;
```
তাহলে এই কুয়েরি রিটার্ন করবে নিচের টেবিল,যেখানে শুরুর ৩ টি রোকে রিটার্ন করছে। :
| Roll No | Name    | Course_ID |
|---------|---------|-----------|
| 101     | Alice   | CSE101    |
| 102     | Bob     | CSE102    |
| 103     | Charlie | CSE103    |

### OFFSET
এটি আমাদেরকে কোনো একটা কুয়েরির রিটার্ন করা ভ্যালু থেকে  নির্দিষ্ট পরিমান row কে স্কিপ করতে সাহায্য করে।  যেমন: আমরা চাচ্ছি আমাদের  Enrollment টেবিল থেকে শুরুর ৩ টি row স্কিপ করে বাকিগুলুকে রিটার্ন করতে। তখনি দরকার হবে OFFSET Clause এর।  এটি লিখার সিনটেক্স হলো :

SELECT কলামের নাম 
FROM  টেবিলের নাম 
OFFSET কতগুলো row স্কিপ করবো তার সংখ্যা;

নিচে  Enrollment টেবিলের জন্য OFFSET ব্যাবহার করে কুয়েরি দেয়া হলো :
``` sql 
SELECT * FROM Enrollment
OFFSET 3;
```
এই কুয়েরি নিচের টেবিল রিটার্ন করবে 
| Roll No | Name   | Course_ID |
|---------|--------|-----------|
| 104     | Diana  | CSE101    |
| 105     | Ethan  | CSE104    |
| 106     | Fiona  | CSE102    |
| 107     | George | CSE105    |
| 108     | George | NULL      |


LIMIT এবং OFFSET এই ২ টি clause কে একসাথে ব্যাবহার করে আমরা pagination ফাঙ্কশনালিটি খুব সহজেই ইমপ্লেটমেন্ট করে ফেলতে পারি। যদি আমরা  Enrollment টেবিলের জন্য নিচের SQL কুয়েরি লিখি 
``` sql 
SELECT * FROM Enrollment
LIMIT 4 OFFSET 3;
 ```
তাহলে আমরা আউটপুট টেবিলে পাবো Enrollment  টেবিলের প্রথম ৩ টি row স্কিপ করেছে এবং প্রথম ৩ row  এর পর থেকে শুরু করে পরবর্তী ৪ টি রোকে রিটার্ন করবে। 

| Roll No | Name   | Course_ID |
|---------|--------|-----------|
| 104     | Diana  | CSE101    |
| 105     | Ethan  | CSE104    |
| 106     | Fiona  | CSE102    |
| 107     | George | CSE105    |

