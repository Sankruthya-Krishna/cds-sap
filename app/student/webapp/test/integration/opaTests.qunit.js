sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'studentinformation/student/test/integration/FirstJourney',
		'studentinformation/student/test/integration/pages/StudentList',
		'studentinformation/student/test/integration/pages/StudentObjectPage'
    ],
    function(JourneyRunner, opaJourney, StudentList, StudentObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('studentinformation/student') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheStudentList: StudentList,
					onTheStudentObjectPage: StudentObjectPage
                }
            },
            opaJourney.run
        );
    }
);