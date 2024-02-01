using {com.s.studentdb as db} from '../db/schema';

service StudentDB {
    entity Gender  as projection on db.Gender;
    entity Student as projection on db.Student;
    entity Courses as projection on db.Courses {
        @UI.Hidden: true
        ID,
        *
    };
    entity Languages as projection on db.Languages
        {
        @UI.Hidden: true
        ID,
        *
    };
    entity Books as projection on db.Books
    {
        @UI.Hidden: true
        ID,
        *
    };
    

}

annotate StudentDB.Student with @odata.draft.enabled;
annotate StudentDB.Courses with @odata.draft.enabled;
annotate StudentDB.Languages with @odata.draft.enabled;
annotate StudentDB.Books with @odata.draft.enabled;

annotate StudentDB.Student with {
    name  @assert.format: '^[a-zA-Z]{2,}$';
    email @assert.format: '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    pan   @assert.format: '[A-Z]{5}[0-9]{4}[A-Z]{1}';
}


annotate StudentDB.Gender with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: code
    },
    {
        $Type: 'UI.DataField',
        Value: description
    },
],
);
annotate StudentDB.Courses with @(UI.LineItem: [
    {
        //$Type: 'UI.DataField',-->no need of using type
        Value: code
    },
    {
        //$Type: 'UI.DataField',
        Value: description
    },
],
UI.FieldGroup #CourseInformation:{
    $Type:'UI.FieldGroupType',
    Data:[
        {
            Value:code
        },
        {
            Value:description
        },
    ],
},
UI.Facets:[
    {
        $Type:'UI.ReferenceFacet',
        ID:'CourseInformationFacet',
        Label:'CourseInfo',
        Target:'@UI.FieldGroup#CourseInformation'
    },
    {
        $Type:'UI.ReferenceFacet',
        ID:'BooksInformationFacet',
        Label:'BooksInfo',
        Target:'Books/@UI.LineItem'
    },
],


);
annotate StudentDB.Books with @(
     UI.LineItem:[
        {
            Value: code
        },
        {
            Value: description
        }
    ],
      UI.FieldGroup #Books :{
        $Type : 'UI.FieldGroupType',
        Data :[
            {
                Value : code,
            },
            {
                Value : description,
            }
        ],
    },
        UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'BooksFacet',
            Label : 'Books',
            Target : '@UI.FieldGroup#Books'
        }
    ]
);
annotate StudentDB.Courses.Books with @(
    UI.LineItem:[
        {
            Value:book_ID,
        },
    ],
  UI.FieldGroup #CourseBooks:{
    $Type:'UI.FieldGroupType',
    Data:[
        {
            Value:book_ID,
        }
    ],
}, 
UI.Facets :[
        {
            $Type:'UI.ReferenceFacet',
            ID:'CourseBook',
            Label:'CourseBooks',
            Target:'@UI.FieldGroup#CourseBooks',
        },
    ], 
);



//as we used many composition we need to create 2 different annotations

annotate StudentDB.Student.Languages with @(
    UI.LineItem: [
    {
        Value: lang_ID,
    },
], 
UI.FieldGroup #StudentLanguages:{
    $Type:'UI.FieldGroupType',
    Data:[
        {
            Value:lang_ID,
        }
    ],
},
    UI.Facets :[
        {
            $Type:'UI.ReferenceFacet',
            ID:'studentLanguage',
            Label:'StudentLanguage',
            Target:'@UI.FieldGroup#StudentLanguages',
        },
    ],

);

annotate StudentDB.Languages with @(
    UI.LineItem: [
    {
        Value: code
    },
    {
        Value: description
    },
],
UI.FieldGroup #Languages: {
    Data:[
    {
        Value: code,
    },
    {
        Value:description
    }
    ]
},
UI.Facets :[
    {
        $Type:'UI.ReferenceFacet',
        ID:'LanguagesFacet',
        Label:'Languages',
        Target:'@UI.FieldGroup#Languages',

    },
]

);




annotate StudentDB.Student with @(
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: st_id
        },
        {
            $Type: 'UI.DataField',
            Value: name
        },
        {
            $Type: 'UI.DataField',
            Label:'Gender',
            Value: gender
        },
        {
            $Type: 'UI.DataField',
            Label:'Course',
            Value: course.code
        },
        {
            $Type: 'UI.DataField',
            Value: email
        },
        {
            $Type: 'UI.DataField',
            Value: pan
        },
        {
            $Type: 'UI.DataField',
            Value: dob
        },
        {
            $Type: 'UI.DataField',
            Value: age
        },
    ],
    UI.SelectionFields: [
        st_id,
        name,
        email,
        pan,
        dob,
        age,
    ],
);

annotate StudentDB.Student with @(
    UI.FieldGroup #StudentInformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: st_id
            },
            {
                $Type: 'UI.DataField',
                Value: name
            },
            {
                $Type: 'UI.DataField',
                Value: email
            },
            {
                $Type: 'UI.DataField',
                Label:'Gender',
                Value: gender
            },
             {
                $Type: 'UI.DataField',
                Label:'Course',
                Value: course_ID
            },
            {
                $Type: 'UI.DataField',
                Value: pan
            },
            {
                $Type: 'UI.DataField',
                Value: dob
            }
        
        ],
    },
    UI.Facets                        : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'StudentInfoFacet',
        Label : 'Student Information',
        Target: '@UI.FieldGroup#StudentInformation',
    },
    {
        $Type : 'UI.ReferenceFacet',
        ID : 'StudentLanguageFacet',
        Label: 'Student Info Language',
        Target: 'Languages/@UI.LineItem',
    }
     ],
);

annotate StudentDB.Student.Languages with {
    lang @(
        Common.Text:lang.description,
    
        Common.ValueListWithFixedValues: true,
     Common.TextArrangement: #TextOnly,
    Common.ValueList: {
        Label: 'Languages',
        CollectionPath: 'Languages',
        Parameters:[
            {
                $Type:'Common.ValueListParameterInOut',
                LocalDataProperty: lang_ID,
                ValueListProperty:'ID'
            },
             {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'code'
            },

            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'description'
            },
        ]
    }
    );
};
annotate StudentDB.Student with {
    gender @(
    Common.ValueListWithFixedValues: true,
    Common.ValueList: {
        Label: 'Genders',
        CollectionPath: 'Gender',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: 'gender',
                ValueListProperty: 'code'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'description'
            }
        ]
    }
);
   course @(
    Common.Text: course.description,
    Common.ValueListWithFixedValues: true,
    Common.TextArrangement: #TextOnly,
    Common.ValueList: {
        Label: 'Courses',
        CollectionPath: 'Courses',
        Parameters: [
            {
                $Type: 'Common.ValueListParameterInOut',
                LocalDataProperty: 'course_ID',
                ValueListProperty: 'ID'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'code'
            },
            {
                $Type: 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'description'
            }
        ]
    }
)
};
annotate StudentDB.Courses.Books with {
    book @(
        Common.Text: book.description,
        Common.TextArrangement: #TextOnly,
        Common.ValueListWithFixedValues: true,
        Common.ValueList : {
            Label: 'Books',
            CollectionPath : 'Books',
            Parameters: [
                {
                    $Type             : 'Common.ValueListParameterInOut',
                    LocalDataProperty : book_ID,
                    ValueListProperty : 'ID'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'code'
                },
                {
                    $Type             : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description'
                },
            ]
        }
    );
};
// annotate StudentDB.Student with {
//     course @(
//     Common.ValueListWithFixedValues: true,
//     Common.TextArrangement: #TextOnly,
//     Common.ValueList: {
//         Label: 'Courses',
//         CollectionPath: 'Courses',
//         Parameters: [
//             {
//                 $Type: 'Common.ValueListParameterInOut',
//                 LocalDataProperty: 'course_ID',
//                 ValueListProperty: 'ID'
//             },
//             {
//                 $Type: 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty: 'code'
//             },
//             {
//                 $Type: 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty: 'description'
//             }
//         ]
//     }
// )}
