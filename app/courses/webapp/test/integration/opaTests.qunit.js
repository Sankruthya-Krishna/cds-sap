sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'courseinformation/courses/test/integration/FirstJourney',
		'courseinformation/courses/test/integration/pages/CoursesList',
		'courseinformation/courses/test/integration/pages/CoursesObjectPage'
    ],
    function(JourneyRunner, opaJourney, CoursesList, CoursesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('courseinformation/courses') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCoursesList: CoursesList,
					onTheCoursesObjectPage: CoursesObjectPage
                }
            },
            opaJourney.run
        );
    }
);