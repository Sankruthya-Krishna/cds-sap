using {com.s.studentdb as db} from '../db/schema';

service StudentDB {
    entity Gender  as projection on db.Gender;
    entity Student as projection on db.Student;

}

annotate StudentDB.Student with @odata.draft.enabled;

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
    UI.SelectionFields:[code,description],
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
        ]
    },
    UI.Facets                        : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'StudentInfoFacet',
        Label : 'Student Information',
        Target: '@UI.FieldGroup#StudentInformation',
    }, ],
);

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
)}
