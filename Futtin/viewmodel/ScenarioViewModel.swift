import Foundation



class ScenarioViewModel: ObservableObject {
    @Published var audioScenarios: [Scenario] = [

        // -------------------- المستوى 1 --------------------
        Scenario(
            level:1,
            title: "استقبال النقد",
            mainAudio: "Receiving Feedback",
            interruptionRange: 25.0...29.0,
            branches: [
               
                ScenarioBranch(userOption: "لا تسمع له، مدراؤنا دايم ينتقدون.", narratorAudio: nil,
                               feedback: "يدعم الدفاعية يغلق باب التطوير", feedbackType: .incorrect),
                ScenarioBranch(userOption: "يمكن طريقته كانت قاسية، بس فيها فرصة للتطور.", narratorAudio: nil,
                               feedback: " يُظهر توازن بين الاحتواء والتوجيه", feedbackType: .correct),
                ScenarioBranch(userOption: "عادي، كلنا ننهان أحيان.", narratorAudio: nil,
                               feedback: "يطبع الإهانة وقد يضعف الوعي بالحقوق.", feedbackType: .neutral)
            ]
            ),
      
        // -------------------- المستوى 2 --------------------
        Scenario(
            level: 2,
            title: "بناء الثقة ",
            mainAudio: "trust_respect_raju",
            interruptionRange: 42.0...44.0,
            branches: [
                ScenarioBranch(userOption: "يا شباب، المزح شيء، بس مهم نحترم كل شخص في الفريق مهما كانت وظيفته.", narratorAudio: "raju_response_1",
                               feedback: "دعم راجو، وعزّز بيئة عمل فيها احترام متبادل — أساس بناء الثقة.", feedbackType: .correct),
                ScenarioBranch(userOption: "ما يحتاج نبالغ، هو الموضوع خفيف ومزح بسيط.", narratorAudio: "raju_response_2",
                               feedback: "خفف التوتر، لكن تجاهل المشكلة الأساسية، ما يحفّز بناء ثقة حقيقية.", feedbackType: .neutral),
                ScenarioBranch(userOption: "خلوا الجو أخف، راجو أكيد فاهم إننا نمزح معاه.", narratorAudio: "raju_response_3",
                               feedback: "افترض الراحة بدون تحقق، وهذا يفتح مجال لسوء فهم أو شعور بالعزلة.", feedbackType: .incorrect)
            ]
        ),
        // -------------------- المستوى 3 --------------------
     
        Scenario(
                level: 3,
                title: "التكيّف مع التغيير",
                mainAudio: "change_ahmad",
                interruptionRange: 29.0...31.0,
                branches: [
                    ScenarioBranch(userOption: "المفروض ما نحول الاجتماع لدراما، نركز على الحلول.", narratorAudio: "ahmad_response_3",
                                   feedback: "ردّك يُشعر الآخر بالرفض، ويغلق باب التعبير — يضعف التواصل في الفريق.", feedbackType: .incorrect),
                    ScenarioBranch(userOption: "أحس بك، وتعب الفريق واضح. نقدر نلاقي حل وسط يساعدنا.", narratorAudio: "ahmad_response_1",
                                   feedback: "ردّك يدعم الأمان النفسي في الفريق — أساس التكيّف الصحي تحت الضغط.", feedbackType: .correct),
                    ScenarioBranch(userOption: "بالنهاية هذا شغل، وكلنا لازم نأقلم نفسنا مع التغييرات.", narratorAudio: "ahmad_response_2",
                                   feedback: "نبرة منطقية، لكنها فاتتها الإشارات العاطفية الواضحة.", feedbackType: .neutral)
                ]
            ),



        // -------------------- المستوى 4 --------------------
        
        Scenario(
            level: 4,
            title: "التحفيز الذاتي ",
            mainAudio: "self_motivation_fares",
            interruptionRange: 38.0...41.0,
            branches: [
                ScenarioBranch(userOption: "هو مديرك يمكن ما يقصد، بس فعلاً تأخرت بحل المشكلة.", narratorAudio: "fares_response_2",
                               feedback: "عقلاني، لكنه خفّف المشاعر بدلاً من الاعتراف بها.", feedbackType: .neutral),
                ScenarioBranch(userOption: "لو تفكر تنقل مكان ثاني، يمكن ترتاح وتبدأ من جديد.", narratorAudio: "fares_response_3",
                               feedback: "فتح باب الانسحاب، ما حفّز الاستمرار – يضعف التحفيز الذاتي.", feedbackType: .incorrect),
                
                    ScenarioBranch(userOption: "إذا أحد ثاني مكانك، ما كان تحمّل ربع اللي سويته.", narratorAudio: "fares_response_1",
                                   feedback: "أعاد التوازن النفسي – مهارة التحفيز الذاتي من خلال دعم الآخرين.", feedbackType: .correct)
            ]
        ),

        // -------------------- المستوى 5 --------------------
        Scenario(
            level: 5,
            title: "حل الخلافات",
            mainAudio: "Conflict Resolution",
            interruptionRange: 22.0...25.0,
            branches: [
                ScenarioBranch(userOption: "واضح أنك حاولت توصلين شعورك بلطف.", narratorAudio: nil,
                               feedback: "يعزز أسلوب التفاهم ويقلل التصعيد.", feedbackType: .correct),
                ScenarioBranch(userOption: "أحيانًا لازم نكون قاسين بعد.", narratorAudio: nil,
                               feedback: "يشجع العدوانية ويضعف التواصل.", feedbackType: .incorrect),
                ScenarioBranch(userOption: "لو سكتّي من البداية كان أفضل.", narratorAudio: nil,
                               feedback: "يدفع للكبت ويتجاهل الاحتياج للتعبير.", feedbackType: .neutral)
            ]
        ),

        // -------------------- المستوى 6 --------------------
      
        Scenario(
            level: 6,
            title: "الوعي الذاتي",
            mainAudio: "self_awareness_request",
            interruptionRange: 33.0...38,
            branches: [
                ScenarioBranch(userOption: "يمكن تبالغ، كلنا نحس كذا أحياناً.", narratorAudio: nil,
                               feedback: "يقلل من المشاعر ويضعف الثقة.", feedbackType: .incorrect),
                
                    ScenarioBranch(userOption: "تبيني أسمع أكثر؟ أعتقد فيه شي أعمق جواك.", narratorAudio: nil,
                                   feedback: "يُظهر تعاطفًا ويفتح مساحة آمنة للتعبير.", feedbackType: .correct),
                ScenarioBranch(userOption: "ليه ما تكلمت مع مديرك؟", narratorAudio: nil,
                               feedback: "يحرف التركيز عن المشاعر ويقدّم حل قبل الاستماع.", feedbackType: .neutral)
            ]
        ),

        // -------------------- المستوى 7 --------------------
        Scenario(
            level: 7,
            title: "اتخاذ قرار مبني على العاطفة",
            mainAudio: "decision_lama",
            interruptionRange: 34.5...38.0,
            branches: [
                ScenarioBranch(userOption: "كنت تقدر تفصل مشاعرك أكثر، التقييم لازم يكون مهني بحت.", narratorAudio: "lama_response_2",
                               feedback: "فيه منطق مهني، لكن تجاهل البُعد الإنساني يضعف الذكاء العاطفي.", feedbackType: .neutral),
                ScenarioBranch(userOption: "يبدو إنك خفت تواجهها بالحقيقة.", narratorAudio: "lama_response_3",
                               feedback: "ردّك كان قاسي ويحمل نبرة لوم، وقد يعيق التعبير الصادق مستقبلاً.", feedbackType: .incorrect),
                
                    ScenarioBranch(userOption: "تقييمك موزون، ما كان قاسي ولا متساهل.", narratorAudio: "lama_response_1",
                                   feedback: "ردّك يعكس نضج عاطفي — قدرت توازن بين الحزم والتعاطف.", feedbackType: .correct)
            ]
        ),

        // -------------------- المستوى 8 --------------------
     
        Scenario(
            level: 8,
            title: "ضبط النفس",
            mainAudio: "Self-Regulation",
            interruptionRange: 34.0...39.0,
            branches: [
                ScenarioBranch(userOption: "اللي سويته يحتاج شجاعة، مو ضعف.", narratorAudio: nil,
                               feedback: "يعزز الثقة في القدرة على ضبط النفس.", feedbackType: .correct),
                ScenarioBranch(userOption: "ممكن كنت أقوى لو رديت.", narratorAudio: nil,
                               feedback: "يشجع على السلوك الاندفاعي.", feedbackType: .incorrect),
                ScenarioBranch(userOption: "السكوت دايمًا مو حل.", narratorAudio: nil,
                               feedback: "تعميم يضعف قيمة التصرّف المتّزن.", feedbackType: .neutral)
            ]
        ),

        // -------------------- المستوى 9 --------------------
    
        Scenario(
            level: 9,
            title: "التعاطف",
            mainAudio: "empathy",
            interruptionRange: 36.0...38.0,
            branches: [
                
                ScenarioBranch(userOption: "أعتقد المشكلة في زميلك، مو فيك.", narratorAudio: nil,
                               feedback: "يغلق باب التعبير ويحوّل الحديث للوم..", feedbackType: .neutral),
                ScenarioBranch(userOption: "انتي حساسة بزيادة، يمكن ما كان يقصد.", narratorAudio: nil,
                               feedback: "يحمل حكم سلبي وقد يضعف الثقة.", feedbackType: .incorrect),
                
                    ScenarioBranch(userOption: "أنا هنا أسمعك، وخذّي وقتك.", narratorAudio: nil,
                                   feedback: "يظهر تعاطفا دون تقديم حل أو حكم، يعزز الأمان العاطفي.", feedbackType: .correct),
            ]
        ),

        // -------------------- المستوى 10 --------------------
        Scenario(
            level: 10,
            title: "المساءلة الذاتية – سارة",
            mainAudio: "accountability_sara",
            interruptionRange: 30.0...32.5,
            branches: [
                ScenarioBranch(userOption: "الكل يتحمّل جزء من اللي صار.", narratorAudio: "sara_response_1",
                               feedback: "عزّز المساءلة بطريقة ذكية، بدون ضغط أو لوم مباشر.", feedbackType: .correct),
                ScenarioBranch(userOption: "كان المفروض تراجع قبل العرض.", narratorAudio: "sara_response_2",
                               feedback: "منطقي، لكنه ما شجّع على تحمّل المسؤولية فعليًا.", feedbackType: .neutral),
                ScenarioBranch(userOption: "مو ذنبك، ما أحد وضّح شي.", narratorAudio: "sara_response_3",
                               feedback: "عزّز التهرب، وأغلق باب النقاش — عكس هدف المساءلة الذاتية.", feedbackType: .incorrect)
            ]
        )
    ]

    func scenario(for level: Int) -> Scenario? {
        audioScenarios.first { $0.level == level }
    }
}
