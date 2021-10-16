const {initialize} = require('koalanlp/Util');

async function someAsyncFunction(){
    // 꼬꼬마와 은전한닢 분석기의 2.0.4 버전을 참조합니다.
    await initialize({
      packages: {KKMA:'2.1.4', EUNJEON:'2.1.6'},
      javaOptions: ["-Xmx4g"],
      verbose: true,
    });
    
    // 초기화 다음 작업...
}

someAsyncFunction().then(
    () => console.log('Finished'),
    (error) => console.error('Error', error)
);
