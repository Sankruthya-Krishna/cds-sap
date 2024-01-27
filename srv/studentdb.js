
const cds = require('@sap/cds');

function calcAge(d) {
    const dob = new Date(d);
    const today = new Date();

    let age = today.getFullYear() - dob.getFullYear();
    const monthDiff = today.getMonth() - dob.getMonth();

    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
        age--;
    }

    return age;
}
module.exports = cds.service.impl(function () {

    const { Student,Gender} = this.entities();
    this.on(['READ'], Student, async(req) => {
        results = await cds.run(req.query);
        if(Array.isArray(results)){
            results.forEach(element => {
             element.age=calcAge(element.dob);
             if(element.gender=='M') 
             {
                element.gender="Male"
             }
             if(element.gender=='F') 
             {
                element.gender="Female"
             }
            });
        }else{
            results.age=calcAge(results.dob);
        }
        
        return results;
    });

    this.before(['CREATE'], Student, async(req) => {
        age = calcAge(req.data.dob);
        if (age<18 || age>45){
            req.error({'code': 'WRONGDOB',message:'Student not the right age for school:'+age, 'target':'dob'});
        }

        let query1 = SELECT.from(Student).where({ref:["email"]}, "=", {val: req.data.email});
        result = await cds.run(query1);
        if (result.length >0) {
            req.error({'code': 'STEMAILEXISTS',message:'Student with such email already exists', target: 'email'});
        }

    });
    this.before(['UPDATE'], Student, async(req) => {
    
        const { email, st_id } = req.data;
        if (email) {
            const query = SELECT.from(Student).where({ email: email }).and({ st_id: { '!=': st_id } });
            const result = await cds.run(query);
            if (result.length > 0) {
                req.error({ code: 'STEMAILEXISTS', message: 'Student with such email already exists', target: 'email' });
            }
        }
    });
    this.on('READ',Gender,async()=>{
        genders=[
            {"code":"F","description":"female"},
            {"code":"M","description":"male"}
        ]
        genders.$count=genders.length;
        return genders;
    })
});
