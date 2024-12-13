import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:khidma/data/jobs_api.dart';
import 'package:khidma/domain/models/job_model.dart';

class HomeController extends GetxController {
  JobsApi jobsApi = JobsApi();

  String selectedCategorie = '';
  updateSelectedCategorie(String newCategory) {
    if (selectedCategorie != newCategory) {
      selectedCategorie = newCategory;
      update();
    } else {
      isFetchingFilteredJobs = false;
      filteredJobs.clear();
      selectedCategorie = '';
      update();
    }
  }

  // fetch selected category jobs
  bool isFetchingFilteredJobs = false;
  List<JobModel> filteredJobs = [];
  fetchSelectedCategoryJobs() async {
    try {
      if (selectedCategorie.isEmpty) return;
      filteredJobs.clear();
      isFetchingFilteredJobs = true;
      update();

      await Future.delayed(
        const Duration(seconds: 3),
      );

      List results = await jobsApi.fetchJobsByCategory(selectedCategorie);
      if (results.isNotEmpty) {
        for (var job in results) {
          filteredJobs.add(
            JobModel.fromMap(job),
          );
        }
      }
      isFetchingFilteredJobs = false;
      update();
    } catch (e) {
      isFetchingFilteredJobs = false;
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Failed to fetch jobs, please try again.',
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  final Map<String, IconData> categorie = {
    'Software Development': Ionicons.code_slash_outline, // Ionicon for coding
    'Design': Ionicons.color_palette_outline, // Ionicon for design
    'Data Science': Ionicons.stats_chart_outline, // Ionicon for data science
    'DevOps': Ionicons.cog_outline, // Ionicon for DevOps
  };

  bool isFetchingJobsLoading = false;
  List<JobModel> popularJobs = [];
  List<JobModel> recentJobs = [];
  List<JobModel> jobs = [];
  fetchJobs() async {
    try {
      isFetchingJobsLoading = true;
      update();
      await Future.delayed(
        const Duration(seconds: 2),
      );
      List<dynamic> results = await jobsApi.fetchJobs();

      for (var job in results) {
        jobs.add(JobModel.fromMap(job));
      }

      recentJobs = jobs.reversed.take(6).toList();
      popularJobs = jobs.take(6).toList();

      isFetchingJobsLoading = false;
      update();
    } catch (e) {
      print(e);
      isFetchingJobsLoading = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong, please try again. $e',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
