import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/models/blog_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('Insert Data on table Blog ', () async {
    BlogModel model = BlogModel(posts: [
      Post(
          id: 1,
          date: "2022-01-01",
          modified: "2022-01-01",
          url: null,
          title: "hi",
          content: "hello content",
          excerpt: "hi excerpt",
          thumbnail: 'hi thumbnail',
          categories: [Category()],
          tags: [Category(id: 1, title: 'hi')],
          author: Author(url: 'www.google.com'),
          comments: [],
          commentCount: 10,
          thumbnailImages: Images(
            full: Full(
              url:
                  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
              width: 12,
              height: 23,
            ),
          ),
          event: 2)
    ]);
    await dbHelper.insertOnBlogTable(model);
    dynamic expectedOuput = [
      {
        'id': 1,
        'date': '2022-01-01',
        'modified': '2022-01-01',
        'url': 'www.google.com',
        'title': 'hi',
        'content': 'hello content',
        'excerpt': 'hi excerpt',
        'thumbnail': 'hi thumbnail',
        'categories': '',
        'tags':
            '[{"id":1,"slug":null,"title":"hi","description":null,"parent":null,"post_count":null}]',
        'author':
            '{"id":null,"slug":null,"name":null,"first_name":null,"last_name":null,"nickname":null,"url":"www.google.com","description":null}',
        'comments': '',
        'comment_count': 10,
        'thumbnail_images':
            '{"full":{"url":"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg","width":12,"height":23},"thumbnail":null,"medium":null,"medium_large":null,"large":null,"post-thumbnail":null}',
        'readdate': '',
        'isread': 0,
        'ignore': 0,
        'event': 0
      }
    ];
    var actualOutput = await dbHelper.getFromBlogTable(1);
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });
  test('get all from table blog', () async {
    dynamic expectedOuput = [
      {
        'id': 1,
        'date': '2022-01-01',
        'modified': '2022-01-01',
        'url': 'www.google.com',
        'title': 'hi',
        'content': 'hello content',
        'excerpt': 'hi excerpt',
        'thumbnail': 'hi thumbnail',
        'categories': '',
        'tags':
            '[{"id":1,"slug":null,"title":"hi","description":null,"parent":null,"post_count":null}]',
        'author':
            '{"id":null,"slug":null,"name":null,"first_name":null,"last_name":null,"nickname":null,"url":"www.google.com","description":null}',
        'comments': '',
        'comment_count': 10,
        'thumbnail_images':
            '{"full":{"url":"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg","width":12,"height":23},"thumbnail":null,"medium":null,"medium_large":null,"large":null,"post-thumbnail":null}',
        'readdate': '',
        'isread': 0,
        'ignore': 0,
        'event': 0
      }
    ];
    var actualOutput = await dbHelper.getFromBlogTable(1);
    expect(actualOutput, expectedOuput);
  });
  test("Get BlogDateTime From Blog", () async {
    var expectedOutput = "20220101";
    String actualOutput = await dbHelper.getBlogDateTime(true);
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Load Blogs", () async {
    var expectedOutput = [
      Post(
        id: 1,
        type: null,
        slug: null,
        url: 'www.google.com',
        status: null,
        title: 'hi',
        titlePlain: null,
        content: "hello content",
        excerpt: 'hi excerpt',
        date: '2022-01-01',
        modified: '2022-01-01',
        categories: null,
        tags: [
          Category(
              id: 1,
              slug: null,
              title: 'hi',
              description: null,
              parent: null,
              postCount: null)
        ],
        author: Author(
            id: null,
            firstName: null,
            lastName: null,
            name: null,
            nickname: null,
            slug: null,
            description: null,
            url: "www.google.com"),
        comments: null,
        attachments: null,
        commentCount: 10,
        commentStatus: null,
        thumbnail: 'hi thumbnail',
        customFields: null,
        thumbnailSize: null,
        thumbnailImages: Images(
            full: Full(
                url:
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                width: 12,
                height: 23),
            thumbnail: Full(height: null, url: null, width: null),
            medium: Full(height: null, url: null, width: null),
            mediumLarge: Full(height: null, url: null, width: null),
            large: Full(height: null, url: null, width: null),
            postThumbnail: Full(height: null, url: null, width: null)),
        event: 0,
      )
    ];
    var actualOutput = await dbHelper.loadBlogs(1);
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Load Daily Blog", () async {
    var actualOutput = await dbHelper.loadDailyBlog('1');
    var expectedOutput = [
      Post(
        id: 1,
        type: null,
        slug: null,
        url: 'www.google.com',
        status: null,
        title: 'hi',
        titlePlain: null,
        content: "hello content",
        excerpt: 'hi excerpt',
        date: '2022-01-01',
        modified: '2022-01-01',
        categories: null,
        tags: [
          Category(
              id: 1,
              slug: null,
              title: 'hi',
              description: null,
              parent: null,
              postCount: null)
        ],
        author: Author(
            id: null,
            firstName: null,
            lastName: null,
            name: null,
            nickname: null,
            slug: null,
            description: null,
            url: "www.google.com"),
        comments: null,
        attachments: null,
        commentCount: 10,
        commentStatus: null,
        thumbnail: 'hi thumbnail',
        customFields: null,
        thumbnailSize: null,
        thumbnailImages: Images(
            full: Full(
                url:
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                width: 12,
                height: 23),
            thumbnail: Full(height: null, url: null, width: null),
            medium: Full(height: null, url: null, width: null),
            mediumLarge: Full(height: null, url: null, width: null),
            large: Full(height: null, url: null, width: null),
            postThumbnail: Full(height: null, url: null, width: null)),
        event: 0,
      )
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Get Search Blog", () async {
    var actualOutput = await dbHelper.getSearchBlog('hi');
    var expectedOutput = [
      Post(
        id: 1,
        type: null,
        slug: null,
        url: 'www.google.com',
        status: null,
        title: 'hi',
        titlePlain: null,
        content: "hello content",
        excerpt: 'hi excerpt',
        date: '2022-01-01',
        modified: '2022-01-01',
        categories: null,
        tags: [
          Category(
              id: 1,
              slug: null,
              title: 'hi',
              description: null,
              parent: null,
              postCount: null)
        ],
        author: Author(
            id: null,
            firstName: null,
            lastName: null,
            name: null,
            nickname: null,
            slug: null,
            description: null,
            url: "www.google.com"),
        comments: null,
        attachments: null,
        commentCount: 10,
        commentStatus: null,
        thumbnail: 'hi thumbnail',
        customFields: null,
        thumbnailSize: null,
        thumbnailImages: Images(
            full: Full(
                url:
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                width: 12,
                height: 23),
            thumbnail: Full(height: null, url: null, width: null),
            medium: Full(height: null, url: null, width: null),
            mediumLarge: Full(height: null, url: null, width: null),
            large: Full(height: null, url: null, width: null),
            postThumbnail: Full(height: null, url: null, width: null)),
        event: 0,
      )
    ];
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("Load All Blogs", () async {
    var expectedOutput = [
      [
        Post(
          id: 1,
          type: null,
          slug: null,
          url: 'www.google.com',
          status: null,
          title: 'hi',
          titlePlain: null,
          content: "hello content",
          excerpt: 'hi excerpt',
          date: '2022-01-01',
          modified: '2022-01-01',
          categories: null,
          tags: [
            Category(
                id: 1,
                slug: null,
                title: 'hi',
                description: null,
                parent: null,
                postCount: null)
          ],
          author: Author(
              id: null,
              firstName: null,
              lastName: null,
              name: null,
              nickname: null,
              slug: null,
              description: null,
              url: "www.google.com"),
          comments: null,
          attachments: null,
          commentCount: 10,
          commentStatus: null,
          thumbnail: 'hi thumbnail',
          customFields: null,
          thumbnailSize: null,
          thumbnailImages: Images(
              full: Full(
                  url:
                      'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
                  width: 12,
                  height: 23),
              thumbnail: Full(height: null, url: null, width: null),
              medium: Full(height: null, url: null, width: null),
              mediumLarge: Full(height: null, url: null, width: null),
              large: Full(height: null, url: null, width: null),
              postThumbnail: Full(height: null, url: null, width: null)),
          event: 0,
        )
      ]
    ];
    var actualOutput = await dbHelper.loadAllBlogs();
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test('Set Blog As Read', () async {
    var blogItem = Post(
        id: 1,
        date: "2022-01-01",
        modified: "2022-01-01",
        url: "2022/11/1",
        title: "hi",
        content: "hello content",
        excerpt: "hi excerpt",
        thumbnail: 'hi thumbnail',
        categories: [Category()],
        tags: [],
        author: Author(),
        comments: [],
        commentCount: 10,
        thumbnailImages: Images(),
        event: 2);
    var actualOutput = await dbHelper.setBlogAsRead(blogItem);
    var expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("Update From Blog", () async {
    BlogModel model = BlogModel(posts: [
      Post(
        id: 1,
        date: "2022-01-01",
        modified: "2022-01-01",
        url: null,
        title: "hi",
        content: "content",
        excerpt: "hi excerpt",
        thumbnail: 'hi thumbnail',
        categories: [Category()],
        tags: [Category(id: 1, title: 'hi')],
        author: Author(url: 'www.google.com'),
        comments: [],
        commentCount: 10,
        thumbnailImages: Images(
          full: Full(
            url:
                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
            width: 12,
            height: 23,
          ),
        ),
        event: 2,
      ),
    ], count: 1);
    await dbHelper.updateBlogTable(model, 1);
    dynamic expectedOuput = [
      {
        'id': 1,
        'date': '2022-01-01',
        'modified': '2022-01-01',
        'url': null,
        'title': 'hi',
        'content': 'content',
        'excerpt': 'hi excerpt',
        'thumbnail': 'hi thumbnail',
        'categories':
            '[{"id":null,"slug":null,"title":null,"description":null,"parent":null,"post_count":null}]',
        'tags':
            '[{"id":1,"slug":null,"title":"hi","description":null,"parent":null,"post_count":null}]',
        'author':
            '{"id":null,"slug":null,"name":null,"first_name":null,"last_name":null,"nickname":null,"url":"www.google.com","description":null}',
        'comments': '[]',
        'comment_count': 10,
        'thumbnail_images':
            '{"full":{"url":"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg","width":12,"height":23},"thumbnail":null,"medium":null,"medium_large":null,"large":null,"post-thumbnail":null}',
        'readdate': '',
        'isread': 1,
        'ignore': 0,
        'event': 0
      }
    ];
    var actualOutput = await dbHelper.getFromBlogTable(1);
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });
  test("Deleted From Table Blog", () async {
    var actualOutput = await dbHelper.deleteFromTableBlog();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
  });
}
