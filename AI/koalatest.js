const {KMR, KKMA} = require('koalanlp/API');const {initialize} = require('koalanlp/Util');const {Tagger, Parser} = require('koalanlp/proc');

async function executor(){
    await initialize({packages: {KMR: '2.0.4', KKMA: '2.0.4'}, verbose: true});
/*
    let tagger = new Tagger(KMR);
    let tagged = await tagger("안녕하세요. 눈이 오는 설날 아침입니다.");
    for(const sent of tagged) {
        console.log(sent.toString());
    }
*/
    let parser = new Parser(KKMA);
    let parsed = await parser("안녕하세요. 눈이 오는 설날 아침입니다.");
    for(const sent of parsed){
        console.log(sent,  "//");
        for(const dep of sent.dependencies){
            console.log(dep.toString(), "//");
        }
    }}

executor().then(
    () => console.log('finished!'),
    (error) => console.error('Error Occurred!', error));
