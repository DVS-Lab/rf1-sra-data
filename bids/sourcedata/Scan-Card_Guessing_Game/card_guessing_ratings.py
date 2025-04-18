##Ratings for SRNDNA

from psychopy import visual, core, event, gui, data, logging
import csv
import datetime
import random
import numpy
import os
import sys

#parameters
useFullScreen = True
useDualScreen=1
DEBUG = False
frame_rate=1
responseKeys=('1','2','3','z','enter','escape')



#subject ID
subjDlg=gui.Dlg(title="Card Guessing Task Ratings")
subjDlg.addField('Enter Subject ID: ') #0
subjDlg.addField('Enter Gender (0 for male, 1 for female): ') #1
subjDlg.addField('Enter Ethnicity (0 for Caucasian, 1 for Other): ') #2
subjDlg.addField('Age:', choices=['18-39','40-64','65+']) #3
subjDlg.addField('Full Screen? (Enter lowercase: y or n):') #4
subjDlg.addField('Session (1/2): ') #5
subjDlg.addField('Friend Name:') #6
subjDlg.addField('Partner Name:') #7
subjDlg.show()

if gui.OK:
    subj_id=subjDlg.data[0]
    subj_gen=subjDlg.data[1]
    subj_eth=subjDlg.data[2]
    subj_age=subjDlg.data[3]
    subj_session=subjDlg.data[5]
    friend_id=subjDlg.data[6]
    stranger_id=subjDlg.data[7]
else:
    sys.exit()


run_data = {
    'Participant ID': subj_id,
    'Date': str(datetime.datetime.now()),
    'Description': 'SRNDNA Pilot - SR Task',
    'Participant Gender': subj_gen,
    'Participant Ethnicity': subj_eth,
    'Participant Age': subj_age,
    'Session (Pre/Post)': subj_session
    }

#window setup
win = visual.Window([800,600], monitor="testMonitor", units="deg", fullscr=useFullScreen, allowGUI=False, screen=useDualScreen)

#checkpoint
print("got to check 1")

#first screen
instruct_screen = visual.TextStim(win, text='Please use the keyboard to answer the following questions about your partners\n\nUse the 1 and 3 keys to move left and right on a scale, and 2 to select.', pos = (0,0), units='norm', height = 0.1)

#image
pictureStim = visual.ImageStim(win, pos=(0,9.5))
imagescale = 6.65

#text
questionStim = visual.TextStim(win, font='Arial', pos = (0,-0.1), units='norm', height = 0.1)


#last screen
exit_screen = visual.TextStim(win, text='Thank you for participating!', pos = (0,0), units='norm', height = 0.1)

#logging
expdir = os.getcwd()
subjdir = '%s/logs/%s' % (expdir, subj_id)
if not os.path.exists(subjdir):
    os.makedirs(subjdir)
log_file = os.path.join(subjdir,'sub{}_SR-Ratings-{}.csv')
trial_data = [r for r in csv.DictReader(open('SRRatings.csv','rU'))]
trials = data.TrialHandler(trial_data[:], 1, method="sequential")

if subj_age == '18-39':
        agerange = 1
elif subj_age =='40-64':
        agerange = 2
else:
        agerange = 3

question_map = {
    '0': 'win',
    '1': 'lose',
    }

stim_map = {
  '3': 'friend',
  '2': 'stranger',
  '1': 'computer',
    }

#clock
globalClock = core.Clock()
logging.setDefaultClock(globalClock)
timer = core.Clock()


#main task
#instructions
instruct_screen.draw()
win.flip()
event.waitKeys(keyList=('1'))
for trial in trials:
    image_label = stim_map[trial['Partner']]
    backdir = os.path.dirname(os.getcwd())
    imagepath = os.path.join(backdir,'Images')
    if image_label == 'stranger':
        image = os.path.join(imagepath, 'SR_%s_%s.jpg') %(stranger_id,agerange)
    else:
        image = os.path.join(imagepath, '%s.png') % image_label
    pictureStim.setImage(image)
    pictureStim.size *=imagescale / max(pictureStim.size)
    question_label = question_map[trial['Trait']]
    #position = trial['position']
    fileName=log_file.format(subj_id,subj_session)

    # rating scale
    scale = visual.RatingScale(win, low=-5, high=5, size=2, tickMarks=['-5','5'],
    markerStart='0',marker='triangle', textSize=.5, showValue=True, scale = '-5 = negative, 0 = neutral,  5 = positive',
    showAccept=True, noMouse=True, maxTime = 0.0, leftKeys = ['1','left'], rightKeys = ['3','right'], acceptKeys = ['2','enter'], pos = (0, -0.55))


    resp=[]
    resp_val=None
    resp_onset=None


    trial_onset = globalClock.getTime()
    while scale.noResponse:
        scale.draw()
        pictureStim.draw()
        questionStim.draw()
        ratingQ = 'Please rate how it felt to %s money with this partner.' % question_label
        questionStim.setText(ratingQ)
        win.flip()

        #resp = event.getKeys(keyList = responseKeys)

        if len(resp)>0:
            if resp[0] == 'escape':
                trials.addData('Rating', scale.getRating())
                os.chdir(subjdir)
                trials.saveAsWideText(fileName)
                os.chdir(expdir)
                win.close()
                core.quit()


    trials.addData('Rating', scale.getRating())



os.chdir(subjdir)
trials.saveAsWideText(fileName)
os.chdir(expdir)

#last screen
exit_screen.draw()
win.flip()
event.waitKeys()
