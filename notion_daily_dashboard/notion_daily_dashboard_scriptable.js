// Notion Settings
const databaseId = 'my-database-id';
const apiKey = 'my-api-key';
const notionVersion = '2022-06-28';
const baseUrl = 'https://api.notion.com/v1/databases/';

// Global Settings
let basicFontSize = 12;
let lineFontSize = 6;
if (Device.isPad()){
    basicFontSize = basicFontSize * 0.9;
    lineFontSize = lineFontSize * 0.9;
}

// Get Date
let now = new Date();
let today = new Date().toISOString().split('T')[0];
console.log(today);

// HTTP request
async function fetchData() {
    let url = baseUrl + databaseId + '/query';
    let request = new Request(url);
    request.method = 'post';
    request.headers = {
        'Content-Type': 'application/json',
        'Notion-Version': notionVersion,
        'Authorization': 'Bearer ' + apiKey
    }
    let reqBody = {
        'filter': {
            'or': [
                {
                    'property': '날짜',
                    'date': {
                        'equals': today
                    }
                }
            ]
        }
    };
    request.body = JSON.stringify(reqBody)
    try {
        // const res = await fetch(request);    // node 실행시
        // return await res.json()              // node 실행시
        const res = await request.loadJSON();   // scriptable 실행시
        return res;                             // scriptable 실행시
    } catch (error) {
        console.error('Error', error);
        return null;
    }
}

// 위젯 생성
async function createWidget() {
    const res = await fetchData();
    if (!res) {
        console.error("데이터를 가져오지 못했습니다.");
        return;
    }
    const events = []; // 일정을 모아놓는 events 객체 (배열)

    // 일정 데이터 정제
    for (let i = 0; i < res.results.length; i++) {
        const prop = res.results[i].properties; // properties
        const tempDict = {}; // 원하는 값을 담을 dictionary
        // tempDict['날짜'] = prop['날짜']['date']['start']; // 제외
        tempDict['시작시간'] = '[ ' + prop['시작시간']['rich_text'][0]['plain_text'] + ' ]';
        try {
            tempDict['2080'] = '/' + prop['2080']['select']['name'] + '/';
        } catch {
            tempDict['2080'] = '/없음/';
        }
        tempDict['일정'] = prop['일정']['title'][0]['plain_text'];
        if (tempDict['일정'].length > 17){
            tempDict['일정'] = tempDict['일정'].slice(0, 17) + '...';
        }else{
            tempDict['일정'] = tempDict['일정'] + ' '.repeat(17 - tempDict['일정'].length);
        }
        tempDict['예상소요시간'] = prop['예상소요시간']['rich_text'][0]['plain_text'];
        try {
            tempDict['상태'] = prop['상태']['select']['name'];
        } catch {
            tempDict['상태'] = '⚪ 시작전';
        }
        events.push(tempDict); // dictionary를 events 배열에 담음
    }

    // 시작시간 오름차순으로 정렬
    events.sort(function (a, b) {
        if (a['시작시간'] < b['시작시간']) return -1;
        if (a['시작시간'] > b['시작시간']) return 1;
        if (a['시작시간'] === b['시작시간']) return 0;
    });

    // 완료한 사항은 뒤로 배치되도록 정렬
    for (let i=0; i < events.length; i++){
        if (events[i]['상태'] == '🟢 완료'){
            // console.log('this');
            ev = events.splice(i, 1);
            console.log(ev);
            events.push(ev[0]);
        }else{
        }
    }

    // 위젯 생성
    let widget = new ListWidget();
    let gradient = new LinearGradient();
    gradient.colors = [new Color("#f5f7fa"), new Color("#c3cfe2")]; // 백그라운드 색상
    gradient.locations = [0, 1];
    widget.backgroundGradient = gradient;

    // 일정 데이터를 텍스트로 위젯에 추가
    if (events.length === 0) {
        let noEventText = widget.addText("오늘 일정이 없습니다.");
        noEventText.textColor = new Color("#ff0000");
        noEventText.font = Font.systemFont(basicFontSize);
        widget.addSpacer(4);
    } else {
        let textItem = widget.addText("📅 오늘 일정 / Notion");
        textItem.textColor = new Color("#000000");
        textItem.font = Font.systemFont(basicFontSize);
        let line = widget.addText("=".repeat(73));
        line.textColor = new Color("#000000");
        line.font = Font.systemFont(lineFontSize);
        for (const event of events) {
            // let eventText = `${event['날짜']} ${event['시작시간']} ${event['일정']} ${event['상태']}`; // 날짜 제외
            let eventText = `${event['시작시간']} ${event['2080']} ${event['일정']} ${event['상태']}`;
            let textItem = widget.addText(eventText);
            textItem.textColor = new Color("#000000");
            textItem.font = Font.systemFont(basicFontSize);
            widget.addSpacer(4);  // 항목 사이에 약간의 간격 추가
        }
    }

    // 위젯 띄우기
    if (config.runsInWidget) {
        Script.setWidget(widget);
    } else {
        widget.presentMedium(); // 스크립트를 Scriptable에서 실행할 때 미리보기 위해 사용
    }

    Script.complete();
}

// 위젯 생성 함수 호출
createWidget()





///////////////////////////////////   archive   ////////////////////////////////////

// node 실행시 응답값 테스트
// fetchData().then(res => {
//     const events = []                     // 일정을 모아놓는 events 객체 (배열)
//     for (let i = 0; i < res.results.length; i++) {
//         prop = res.results[i].properties; // properties
//         tempDict = {};                    // 원하는 값을 담을 dictionary
//         tempDict['날짜'] = prop['날짜']['date']['start'];
//         tempDict['시작시간'] = prop['시작시간']['rich_text'][0]['plain_text']
//         tempDict['일정'] = prop['일정']['title'][0]['plain_text']
//         tempDict['예상소요시간'] = prop['예상소요시간']['rich_text'][0]['plain_text']
//         try {
//             tempDict['상태'] = prop['상태']['select']['name'];
//         } catch {
//             tempDict['상태'] = '⚪ 시작전';
//         }
//         events.push(tempDict);             // dictionary를 events 배열에 담음
//     }
//     events.sort(function (a, b) {          // 시작시간 오름차순으로 정렬
//         if (a['시작시간'] < b['시작시간']) return -1;
//         if (a['시작시간'] > b['시작시간']) return 1;
//         if (a['시작시간'] === b['시작시간']) return 0;
//     })
//     console.log(events);
// });