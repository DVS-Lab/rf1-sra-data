# Changelog

(2025/06/25) - Added a new phone line (267) 641-2216 to OpenPhone for Gambling2025. It adds $60 to the annual payment

(2025/04/08) - Updated consents with stamped 4/2/2025 in REDCap to include NIH language and remove logic trap questions. 

(2025/03/18) - Updated REDCap fmri session notes to include visual time check for protocol card parameters.

(2025/03/18) - First scan after upgrade to Siemens XA30 from VE11. Protocol cards will need manual changes for each scan for the forseeable future. Will update when this is no longer the case, and protocols can be saved properly. 

(2024/12/18) - last question of BVMT recognition has been fixed to be right side up. We created a new variable with the appendage _rightsideup

(2024/12/17) - Upgraded fmriprep and heudiconv to 24.1.1 and 1.3.2, respectively. 

(2024/11/07) - a_screener_meds question that asks what medication they take has been unhidden. It was hidden from ISTART

(2024/09/24) - Purchased OpenPhone using the P card https://my.openphone.com/settings/billing 

(2024/09/09) - Extended mock scan now will have breaks and snacks

(2024/09/04) - Changed recruitment protocol to be able to handle participants who said they did not have a friend from the island screener. We will now ask them for their friend info on the screener

(2024/06/27) - MCI participants will not be doing AUDIT, DUDIT, DOSPERT or AQ. Added a question to Island Screener that asks: "are you doing this survey online or on Temple University's campus with a researcher?" if they say with researcher then it'll cut them. That data will also pipe to RF1 subject info and cut AQ from MSQ

(2024/06/20) - Changed lotto_id field in island screener 

(2024/05/25) - Started full in person protocol for the MCI participants in Tania's lab. $100 for first visit (island screener + shortened mock scan + calling their friend), $100 for the scan visit (shortened scan), $50 bonus. 

(2024/05/21) - Deleted the appt1 and appt2 scoring reports since the info all lives in the full scoring report

(2024/05/21) - Added baseline phys variavbles to scoring repoort

(2024/03/20) - Preprocessed all subject data with fmriprep version 23.2.1 and Heudiconv version 1.1.0

(2024/02/07) - REDCap - Avi manually copied 10716's data from the RF1 project to the Island screener

(2024/02/06) - REDCap - Re-ordered the Island screener so the longest surveys are at the end. Old order: audit, dudit, usi, fevs, promis, pmas, pam, mpss, ses, fraud, dospert, faq, ecog, bbgs, uclal

(2024/02/05) - Began FEVS, BBGS, and UCLAL recall. Also fixed SES scoring variables in the Island Screener.

(2024/01/11) - deleted Island Screener 953 (duplicate of 1573 but without FEVS)

(2024/01/08) - Fixed typos in pnr_adult_(p7,p8,n6,n7) in Extra Time Questionnaires

(2024/01/08) - First two 55+ recall visits

(2024/01/07) - New receipt made for 55+ recall participants

(2024/01/03) - Sam Yelman piped the receipt signatures for 10555, 10559 and 10590 from the second instance of the receipt to the first instance of the receipt, and I manually copied the rest of the information over.

(2024/01/03) - Set the date of the sub_dateupdated variable (PID 1146) to today for 10310_BE, 10326_BE, 10337_BE, 10358_BE, 10592, 10694, 10737, 10771, 10824, 10834, 10847, 10864, 10871, 10878, and 10824

(2024/01/03) - Re-sent the receipts to the two particpants who were missing signatures: 10836 and 10652. 10836 was Karen and Ronan's visit, and 10652 was sent the full payment in giftcards in the receipt.

(2024/01/02) - REDCap - Added the missing 's' in 'thinks' to gs_adult_20 in the RF1 project

(2023/23/15) - REDCap - Receipt data consolidated to the 'Receipt' instrument in the 'fMRI Session Questionnaires' event

(2023/23/15) - REDCap - Payment Info data consiladated to the 'Payment Info' instrument in the 'fMRI Session Questionnaires' event

(2023/23/15) - REDCap - Downloaded a version of 10555 and 10657 payment info in prep for cross event consolidation since they have repeat instances that cannot be moved across events. They now exist in a folder called 'Payment Info' in project 1146's file repository. 

(2023/12/13) - REDCap - Appointment 2 covid data consolidated to the 'Covid19 Tubric Screener 2' instrument in the 'fMRI Session Questionnaires' event

(2023/12/12) - REDCap - Consents for Friend in Recruitment Database updated to 11/20/23 versions

(2023/12/05) - REDCap - Consents for RF1 and Island Screener REDCap Projects updated to the 11/20/23 approved versions

(2023/12/05) - Edited mock scan intro ppt by converting to PDF

(2023/12/04) - REDCap - Deleted old EROS calculated subscales, and added four correct EROS subscales

(2023/12/04) - REDCap - Made all of the questions in mock scan questionnaires required fields.

(2023/12/1) - First 55+ mock scan (10866) is administered successfully by Cooper J Sharp

(2023/11/29) - REDCap - Brief Biosocial Gambling Screener and UCLA Lonliness Scale added to Island Screener

(2023/11/27) - Fixed card_guessing_ratings.py by adding SRratings.csv back from being accidentally deleted

(2023/11/27) - REDCap - Added KBIT-2 Matrices to the REDCap

(2023/11/22) - Consents using the 5/24/2023 consent form have been downloaded for record in REDCap file repository. 10608, 10713, 10781, 10783 needed to be manually downloaded since they were marked as incomplete. 

(2023/11/22) - Downloaded all RF1 consents as a zip onto Avi's computer

(2023/11/22) - REDCap - Deleted 10666 data

(2023/11/15) - Added attention checks and quality commitment to the Island Screener within FEVS, DOSPERT, and Metal Screener

(2023/11/2) - REDCap - Imported 5 participants' FEVS data (RF1_10391a, RF1_10462a, RF1_10486, RF1_10541, RF1_10581) from RF1 to IS

(2023/10/31) - REDCap - Imported 10317 data (ses) from RF1 to IS 

(2023/10/31) - REDCap - Imported 10559 data (audit, dudit, usi, fevs, pmas, pam, mspss, ses) from RF1 to IS 

(2023/10/27) - card_guessing_ratings.py script not working -- error calling file on line 80

(2023/10/24) - Suchita recruitment shift added (9 - 12 Monday, 4:30 - 7:30 Tuesday, 1- 5 Saturday)

(2023/10/23) - Mariami recrutiment shift added (12 - 3 Wednesday, 3 - 5 Thursday)

(2023/10/10) - REDCap - Added repeating instance to Recruitment database Subject Information for snowball payment

(2023/09/09) - REDCap - Moved the travel reimbursement question from payment info to reciept

(2023/09/29) - First participant (10719) ran under new IOS protocol

(2023/09/28) - Huiling cleared batch of subs from XNAT

(2023/09/28) - REDCap - instruments moved for organization in RF1 SRPAL project (blood pressure seperated from session notes)

(2023/09/28) - Changes made to IOS to include the partners that the participant could be playing with during real scan runs

(2023/09/26) - Facebook Ad paused ____ responses collected 

(2023/09/20) - JSON files for subs with two localizers and no fmaps edited to exclude post-localizer fmapless functional runs

(2023/09/20) - REDCap - Imported FAQ data from rec database to island screener

(2023/09/19) - Added fast T1 to RF1-SRA protocol in the event that participant needs to get out between runs

(2023/09/19) - Added ECog-12 to I assessmIsland Screener for MCent 

(2023/09/18) - Added FAQ skeleton to island screener

(2023/09/12) - Facebook Ad began running with MayoSeitz

(2023/09/10) - Params generated for first SP2 subject. Proper syntax will be #####sp to adhere to BIDS formatting

(2023/09/10) - Sharedreward_5button.py edited for use in SP2 (MB and ME options updated, IP added) 

(2023/09/10) - Sequence Pilot 2.0 restarting, used old protocols from SP1. New protocols copied and 6 counterbalances created. 

(2023/08/28) - REDCap - receipt "cash custodian" field cleared so that Dave could sign in Ori's absence

(2023/08/10) - Updated SharedReward_5button.py dropdown menu options to include new MBME settings 

(2023/08/10) - Ran Sequence Pilot 2.0 pilot visit using internal RA as subject. 

(2023/08/04) - REDCap - Edited Isalnd Screener, added visual aid for the SES ladder, and dudit questions

(2023/08/03) - REDCap - Changed gullibilty scale and scoring from 39 Question to 12 Question

(2023/08/03) - Changed flip angle to 50 degrees after discussing with Handwerker

(2023/08/01) - Admin - POC for Ad company switched Todd Daniels to Julia Livesey 

(2023/07/30) - Admin - Begin period of ecode-only payment during Ori to Cooper cash custodian transition period 

(2023/07/24) - REDCap (edit #341) - We stopped piping the data from the island screener to the Recruitment Database

(2023/07/20) - Tania said in an email with Avi  "For the TICS, the proposed cut score varies by paper. I think we could be conservative and use a cut score of 36 for people < age 75 and 33 for people > age 70. Those cut scores are based on Cook et al 2009.   Others (Knopman et al) have proposed a lower cut score of 31 but they included clinic referrals in their sample. So let’s use the more conservative cut scores. For the FAQ, the cut off is 9. If the FAQ is greater than 9, then the person should not be recruited bc that is the dementia range."

(2023/07/18) - Dave and Avi discussed giving Jamie Riley our flyer to send to their participants (need IRB approval for the flyer).

(2023/07/17) - Tania said in a meeting that TICS and FAQ would be the only measures necessary to determine MCI. 

(2023/06/26) - REDCap (edit #178) - Changed fyfa measure to short form + added scoring for it

(2023/06/22) - REDCap (edit #176) - Moved cog reflection task from questionnaires for home to ext

(2023/06/21) - REDCap (edit #173) - Yale Food Addiction Scale replaced with short-form in Extra Time Questionnaires

(2023/06/07) - REDCap (edit #168) - Added second blood pressure to both appt session notes

(2023/05/18) - REDCap (edit #156) - Added dospert to from_screener

(2023/05/16) - GitHub - Edit to socialdoors recall instructions - Commit: [11cfa852eeee15a8e0dc6fc7ac182ec3f082e22f](https://github.com/DVS-Lab/rf1-sra/commit/11cfa852eeee15a8e0dc6fc7ac182ec3f082e22f)

(2023/05/09) - REDCap (edit #146) - [fraud_island] --> [fraud_island_credit] added to from_screener (12 fields)

(2023/05/08) - GitHub - Removes lines about Q4H since it was moved to island - Commit: [86dc25ebaa3262e5aeab7f7316d296fa25d06c20](https://github.com/DVS-Lab/rf1-sra/commit/86dc25ebaa3262e5aeab7f7316d296fa25d06c20)

(2023/04/26) - REDCap (edit #***) - Moved from postscan_questionnaires to prescan_questionnaires:
  - [norc_##]
  - [nbs_adult_##]
  - [bsmas_##]
- Moved from postscan_questionnaires to mockscan_questionnaires:
  - [sogs_##]
  - {aq_adult_##]
  - [tei_q##]
  - [scaared_adult_##]
- Moved from questionnaires_for_home to postscan_quesiotionnaires:
  - [gen_trust_#]
- Social doors instructions resized
- Commit: [56b35383e69f80c48dc9deb8f88e2f5507284d0a](https://github.com/DVS-Lab/rf1-sra/commit/56b35383e69f80c48dc9deb8f88e2f5507284d0a)

(2023/04/26) - REDCap (edit #124) - [fraud_adult_retest_1] and [fraud_adult_retest_2] added to postscan_questionnaires

(2023/04/05) - REDCap (edit #105) - [mspss_adult_##_retest] added to prescan questionnaires

(2023/04/04) - REDCap (edit #104) - [pam_adult_##_retest] added to prescan_questionnaires

(2023/03/31) - REDCap (edit #102) - [pam_adult_17] added to pam question set (we changed fields and stuff too I think)

(2023/03/27) - REDCap (edit #87) - [fs_tg_1a] to [fs_sessionnotes_9c] were added ~60 fields (no clue what they are –AD)

(2023/03/22) - REDCap (edit #83) - Removed [aadis_f_q#]

(2023/03/15) - REDCap (edit #79) - Moved from postscan_questionnaires to from_screener:
  - [victim_fraud_yn]
  - [fraud_event]
  - [fraud_adult_1]
  - [fraud_adult_2]
  - [fevs_#]
  - [aadis_f_q#]
- Moved from mockscan_questionnaires to from_screener:
  - [mspss_adult_##]
- Moved from questionnaires_for_home to from_screener:
  - [promis_adult_##]
  - SES and op_####
  - [pmas_adult_##]
  - [usi_adult_##]
  - [audit_adult_##] and [dudit_adult_##]
  - [pam_adult_##]
- Added birth city for GUID tool to from_screener (from admin agenda)

(2023/03/09) - GitHub rf1-sra - Updated mock scan powerpoint to mention island screener payment - Commit: [8cacba977166581d2a2f8cde3040bb796c7199bb](https://github.com/DVS-Lab/rf1-sra/commit/8cacba977166581d2a2f8cde3040bb796c7199bb)

(2023/03/06) - IRB - Approved amendments:
  - Removing left-handed and metabolic disorders exclusionary criteria
  - Including the online (island) screener
  - Waived informed consent for the online screener
  - Including raffle info on the landing page

(2023/03/06) - GitHub rf1-sra - Updated mock scan powerpoint to correct incentive structure - Commit: [3182f625002bea925adafcfaff94377e9ba23646](https://github.com/DVS-Lab/rf1-sra/commit/3182f625002bea925adafcfaff94377e9ba23646#diff-cf94eee262c95ddaf2e49065a8a35a6c5d6b8e747702d3dc9f7392d7a8859b43)

(2023/02/16) - REDCap (edit #31) - Started collecting last name [sub_l_name]

(2023/02/07) - REDCap (edit #24) - [aadis_f_q#] added to postscan_questionnaires

(2022/12/21) - REDCap (edit #15) - [bpaqsf_1] to [bpaqsf_12] removed

(2022/12/21) - REDCap (edit #14) - PANAS moved from postscan_questionnaires to prescan_questionnaires + [ses_1] removed

(2022/12/20) - REDCap (edit #13) - [rent_or_own_prop] added to SES

(2022/12/19) - GitHub rf1-aging - UGDG (mock scan): # of trials changed from 36 to 30, values changed from 16:32 to 15:2:25, combinations changed from 0.06:0.13:0.6 to 0.05 .10 .25 .50, counterbalance changed from A;B;A to A;B;A;B;A;B;A

(2022/12/19) - REDCap (edit #11) - Removed the "P2" lines from the PROMIS pool

(2022/12/08) - REDCap (edit #8) - [op_additional_info] added to SES op
