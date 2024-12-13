import 'package:get/get.dart';
import 'package:khidma/data/bookmarks_api.dart';
import 'package:khidma/domain/models/bookmark_model.dart';
import 'package:khidma/domain/models/job_model.dart';
import 'package:khidma/domain/models/user_model.dart';

class BookmarksController extends GetxController {
  BookmarksApi bookmarksApi = BookmarksApi();
  final List<BookmarkModel> bookmarks = [];
  bool isFetchingBookmarks = false;
  // FETCH BOOKMARKS FROM
  fetchBookmarks(userID) async {
    try {
      bookmarks.clear();
      isFetchingBookmarks = true;
      update();
      await Future.delayed(
        const Duration(seconds: 2),
      );
      List fetchedBookmarks = await bookmarksApi.fetchBookmarks(userID);
      print(fetchedBookmarks);
      if (fetchedBookmarks.isNotEmpty) {
        for (var element in fetchedBookmarks) {
          bookmarks.add(BookmarkModel.fromJson(element));
        }
      }
      isFetchingBookmarks = false;
      update();
    } catch (e) {
      isFetchingBookmarks = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Somethig went wrong fetching the bookmarks $e',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // ADD BOOKMARK
  addBookmark(UserModel user, JobModel job) async {
    try {
      int result = await bookmarksApi.addBookmark(user.id, job.id);
      if (result == 201) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Bookmark added successfully',
            duration: Duration(seconds: 2),
          ),
        );
        bookmarks.add(BookmarkModel(bookmarkID: 99, user: user, job: job));
        update();
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Somethig went wrong adding the bookmark',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // DELETE BOOKMARK
  deleteBookmark(userID, jobID) async {
    try {
      int result = await bookmarksApi.deleteBookmark(userID, jobID);
      if (result == 200) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Bookmark deleted successfully',
            duration: Duration(seconds: 2),
          ),
        );
        bookmarks.removeWhere((bookmark) =>
            bookmark.job.id == jobID && bookmark.user.id == userID);
        update();
      } else {
        throw Exception();
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Somethig went wrong deleting the bookmark',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // service to update bookmark icon
  bool isSelectedJobInBookamrks(userID, jobID) {
    return bookmarks.any(
        (bookmark) => bookmark.job.id == jobID && bookmark.user.id == userID);
  }

  // ADDING OR DELETING BOOKMARK
  toggleBookmark(UserModel user, JobModel job) async {
    if (isSelectedJobInBookamrks(user.id, job.id)) {
      await deleteBookmark(user.id, job.id);
    } else {
      await addBookmark(user, job);
    }
  }
}
