// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter_test/flutter_test.dart';
import 'package:nepali_patro_sql_package/database/db_constraints.dart';
import 'package:nepali_patro_sql_package/models/blog_model.dart';
import 'package:nepali_patro_sql_package/nepali_patro_sql_package.dart';
import 'nepali_patro_sql_package_test.dart';

void main() async {
  sqfliteTestInit();
  final dbHelper = DatabaseHelper.instance;
  test('insertBlog ', () async {
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
    await dbHelper.insertBlog(model);
    List<dynamic> expectedOuput = [
      {
        Blogs.id: 1,
        Blogs.date: '2022-01-01',
        Blogs.modified: '2022-01-01',
        Blogs.url: 'www.google.com',
        Blogs.title: 'hi',
        Blogs.content: 'hello content',
        Blogs.excerpt: 'hi excerpt',
        Blogs.thumbnail: 'hi thumbnail',
        Blogs.categories: '',
        Blogs.tags:
            '[{"id":1,"slug":null,"title":"hi","description":null,"parent":null,"post_count":null}]',
        Blogs.author:
            '{"id":null,"slug":null,"name":null,"first_name":null,"last_name":null,"nickname":null,"url":"www.google.com","description":null}',
        Blogs.comments: '',
        Blogs.comment_count: 10,
        Blogs.thumbnail_images:
            '{"full":{"url":"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg","width":12,"height":23},"thumbnail":null,"medium":null,"medium_large":null,"large":null,"post-thumbnail":null}',
        Blogs.readdate: '',
        Blogs.isread: 0,
        Blogs.ignore: 0,
        Blogs.event: 0
      }
    ];
    List? actualOutput = await dbHelper.getBlogById(1);
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });
  test('getFromBlogTable', () async {
    List<Map<dynamic, dynamic>> expectedOuput = [
      {
        Blogs.id: 1,
        Blogs.date: '2022-01-01',
        Blogs.modified: '2022-01-01',
        Blogs.url: 'www.google.com',
        Blogs.title: 'hi',
        Blogs.content: 'hello content',
        Blogs.excerpt: 'hi excerpt',
        Blogs.thumbnail: 'hi thumbnail',
        Blogs.categories: '',
        Blogs.tags:
            '[{"id":1,"slug":null,"title":"hi","description":null,"parent":null,"post_count":null}]',
        Blogs.author:
            '{"id":null,"slug":null,"name":null,"first_name":null,"last_name":null,"nickname":null,"url":"www.google.com","description":null}',
        Blogs.comments: '',
        Blogs.comment_count: 10,
        Blogs.thumbnail_images:
            '{"full":{"url":"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg","width":12,"height":23},"thumbnail":null,"medium":null,"medium_large":null,"large":null,"post-thumbnail":null}',
        Blogs.readdate: '',
        Blogs.isread: 0,
        Blogs.ignore: 0,
        Blogs.event: 0
      }
    ];
    List? actualOutput = await dbHelper.getBlogById(1);
    expect(actualOutput, expectedOuput);
  });
  test("getBlogDateTime", () async {
    var expectedOutput = "20220101";
    String actualOutput = await dbHelper.getBlogDateTime(true);
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("loadBlogs", () async {
    List<Post> expectedOutput = [
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
    List<Post> actualOutput = await dbHelper.loadBlogs(1);
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("loadDailyBlog", () async {
    List<Post> actualOutput = await dbHelper.loadDailyBlog('1');
    List<Post> expectedOutput = [
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

  test("getSearchBlog", () async {
    List<Post> actualOutput = await dbHelper.getSearchBlog('hi');
    List<Post> expectedOutput = [
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
  test("loadAllBlogs", () async {
    List<List<Post>> expectedOutput = [
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
    List<List<Post>> actualOutput = await dbHelper.loadAllBlogs();
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });
  test("loadBlogsByDate", () async {
    List<Post> actualOutput = await dbHelper.loadBlogsByDate('2022-01-01');
    List<Post> expectedOutput = [
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
  test('setBlogAsRead', () async {
    Post blogItem = Post(
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
    dynamic actualOutput = await dbHelper.setBlogAsRead(blogItem);
    bool expectedOutput = true;
    expect(actualOutput, expectedOutput);
    await dbHelper.close();
  });

  test("updateBlog", () async {
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
    await dbHelper.updateBlog(model, 1);
    List<Map<dynamic, dynamic>> expectedOuput = [
      {
        Blogs.id: 1,
        Blogs.date: '2022-01-01',
        Blogs.modified: '2022-01-01',
        Blogs.url: null,
        Blogs.title: 'hi',
        Blogs.content: 'content',
        Blogs.excerpt: 'hi excerpt',
        Blogs.thumbnail: 'hi thumbnail',
        Blogs.categories:
            '[{"id":null,"slug":null,"title":null,"description":null,"parent":null,"post_count":null}]',
        Blogs.tags:
            '[{"id":1,"slug":null,"title":"hi","description":null,"parent":null,"post_count":null}]',
        Blogs.author:
            '{"id":null,"slug":null,"name":null,"first_name":null,"last_name":null,"nickname":null,"url":"www.google.com","description":null}',
        Blogs.comments: '[]',
        Blogs.comment_count: 10,
        Blogs.thumbnail_images:
            '{"full":{"url":"https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg","width":12,"height":23},"thumbnail":null,"medium":null,"medium_large":null,"large":null,"post-thumbnail":null}',
        Blogs.readdate: '',
        Blogs.isread: 1,
        Blogs.ignore: 0,
        Blogs.event: 0
      }
    ];
    var actualOutput = await dbHelper.getBlogById(1);
    expect(actualOutput, expectedOuput);
    await dbHelper.close();
  });
  test("deleteAllBlog", () async {
    var actualOutput = await dbHelper.deleteAllBlog();
    dynamic expectedOutput;
    expect(actualOutput, expectedOutput);
  });
}
