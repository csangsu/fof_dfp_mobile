class UserInfoData {
  String custNo;
  int snsCnt;
  String custId;
  String sendbrdId;
  String custNm;
  String custClsCd;
  String custStatCd;
  List<String> custAuths;
  String ntnCd;
  String gndrClsCd;
  String brdt;
  String hp;
  String eml;
  String joinTypCd;
  String joinYmd;
  String aplyYmd;
  String drmtSchdYmd;
  String drmtYmd;
  String spsnYmd;
  String whdwlYmd;
  String cnptCd;
  String cnptNm;
  String bzmnRegNo;
  String deptNm;
  String jbgdNm;
  String wrcTelno;
  String faxno;
  String lastLgnDtm;
  String statCd;
  String langCd;
  String usrClsCd;
  String ogdpCoId;
  Map<String, Map<String, String>> snsInfo;
  String sendbirdUsrId;
  String sendbirdNickNm;
  bool newsLetterAgreeYn;
  String joinAplyStatCd;
  int masterCnt;
  int regularCnt;

  UserInfoData(
      this.custNo,
      this.snsCnt,
      this.custId,
      this.sendbrdId,
      this.custNm,
      this.custClsCd,
      this.custStatCd,
      this.custAuths,
      this.ntnCd,
      this.gndrClsCd,
      this.brdt,
      this.hp,
      this.eml,
      this.joinTypCd,
      this.joinYmd,
      this.aplyYmd,
      this.drmtSchdYmd,
      this.drmtYmd,
      this.spsnYmd,
      this.whdwlYmd,
      this.cnptCd,
      this.cnptNm,
      this.bzmnRegNo,
      this.deptNm,
      this.jbgdNm,
      this.wrcTelno,
      this.faxno,
      this.lastLgnDtm,
      this.statCd,
      this.langCd,
      this.usrClsCd,
      this.ogdpCoId,
      this.snsInfo,
      this.sendbirdUsrId,
      this.sendbirdNickNm,
      this.newsLetterAgreeYn,
      this.joinAplyStatCd,
      this.masterCnt,
      this.regularCnt);

  factory UserInfoData.fromMap(Map<String, dynamic> map) {
    return UserInfoData(
      map['custNo'] as String,
      map['snsCnt'] as int,
      map['custId'] as String,
      map['sendbrdId'] as String,
      map['custNm'] as String,
      map['custClsCd'] as String,
      map['custStatCd'] as String,
      map['custAuths'] as List<String>,
      map['ntnCd'] as String,
      map['gndrClsCd'] as String,
      map['brdt'] as String,
      map['hp'] as String,
      map['eml'] as String,
      map['joinTypCd'] as String,
      map['joinYmd'] as String,
      map['aplyYmd'] as String,
      map['drmtSchdYmd'] as String,
      map['drmtYmd'] as String,
      map['spsnYmd'] as String,
      map['whdwlYmd'] as String,
      map['cnptCd'] as String,
      map['cnptNm'] as String,
      map['bzmnRegNo'] as String,
      map['deptNm'] as String,
      map['jbgdNm'] as String,
      map['wrcTelno'] as String,
      map['faxno'] as String,
      map['lastLgnDtm'] as String,
      map['statCd'] as String,
      map['langCd'] as String,
      map['usrClsCd'] as String,
      map['ogdpCoId'] as String,
      map['snsInfo'] as Map<String, Map<String, String>>,
      map['sendbirdUsrId'] as String,
      map['sendbirdNickNm'] as String,
      map['newsLetterAgreeYn'] as bool,
      map['joinAplyStatCd'] as String,
      map['masterCnt'] as int,
      map['regularCnt'] as int,
    );
  }
}
