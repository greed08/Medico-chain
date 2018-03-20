pragma solidity ^0.4.17;
// We have to specify what version of compiler this code will compile with
contract Medic{
mapping (address => uint8) public patient ;
uint8 docsTillNow ;
uint8 patientTillNow ;

mapping (address => uint8) doctor ;
mapping (address => uint8) patientKaDoc;
 mapping (address => uint8) docKaPatient;
mapping (address => uint8) visPatient ;
mapping (address => uint8) visDoctor ;
mapping (address => uint8) sessionDoc;
mapping (address => uint8) sessionPat;
uint8 [1000][1000] Permission ;
address [][1000]  DoctorList ;
address [][1000] PatientList;
function Medic() public{
    docsTillNow=0;
    patientTillNow=0;
}
function grantAcess( uint AC,address _doc, address _patient) public{
    if(AC==1){
        if(visDoctor[_doc]!=1){
            doctor[_doc]=docsTillNow;
            docsTillNow++;
            visDoctor[_doc]=1;
           
           
        }
        if(visPatient[_patient]!=1){
            patient[_patient]=patientTillNow;
            patientTillNow++;
            visPatient[_patient]=1;
        }
         DoctorList[patient[_patient]].push(_doc);
         PatientList[doctor[_doc]].push(_patient);
         patientKaDoc[_patient]++;
         docKaPatient[_doc]++;
        Permission[patient[_patient]][doctor[_doc]]=1;
       
    }
  else{
        if(visPatient[_patient]==1 && visDoctor[_doc]==1)
         Permission[patient[_patient]][doctor[_doc]]=0;
  }
   
}
function login(address _add, bool isDoc) public{
    if(isDoc)sessionDoc[_add]=1;
    else
       sessionPat[_add]=1;
}
 function logout(address _add, bool isDoc) public{
    if(isDoc)sessionDoc[_add]=0;
    else
       sessionPat[_add]=0;
}
function getThePatients(address _doc) public returns (address []){
    address [] temp;
    //for(uint i=0;i<DoctorList[patient[_patient]].length;i++)
      //temp.push(DoctorList[patient[_patient]][i]);
      for(uint i=0;i<docKaPatient[_doc];i++)
      temp.push(PatientList[doctor[_doc]][i]);
      //temp.push(DoctorList[patient[_patient]][1]);
      return temp;
}
function getTheDocs(address _patient) public returns (address []){
    address [] temp;
    //for(uint i=0;i<DoctorList[patient[_patient]].length;i++)
      //temp.push(DoctorList[patient[_patient]][i]);
      for(uint i=0;i<patientKaDoc[_patient];i++)
      temp.push(DoctorList[patient[_patient]][i]);
      //temp.push(DoctorList[patient[_patient]][1]);
return temp;
}
}
