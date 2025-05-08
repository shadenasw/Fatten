import Foundation

class ScenarioViewModel: ObservableObject {
    @Published var scenarios: [Scenario] = [

        // -------------------- المستوى 1 --------------------
        Scenario(
            level: 1,
            title: "الوعي الذاتي",
            mainAudio: "self_awareness_request",
            interruptionRange: 19.0...22.0,
            branches: [
                ScenarioBranch(userOption: "تبيني أسمع أكثر؟ أعتقد فيه شي أعمق جواك.", narratorAudio: nil),
                ScenarioBranch(userOption: "يمكن تبالغ، كلنا نحس كذا أحياناً.", narratorAudio: nil),
                ScenarioBranch(userOption: "ليه ما تكلمت مع مديرك؟", narratorAudio: nil)
            ]
        ),

        // -------------------- المستوى 2 --------------------
        Scenario(
            level: 2,
            title: "التعاطف",
            mainAudio: "empathy_noura",
            interruptionRange: 20.0...23.5,
            branches: [
                ScenarioBranch(userOption: "أنا هنا أسمعك، وخذّي وقتك.", narratorAudio: nil),
                ScenarioBranch(userOption: "أعتقد المشكلة في زميلك، مو فيك.", narratorAudio: nil),
                ScenarioBranch(userOption: "انتي حساسة بزيادة، يمكن ما كان يقصد.", narratorAudio: nil)
            ]
        ),

        // -------------------- المستوى 3 --------------------
        Scenario(
            level: 3,
            title: "ضبط النفس",
            mainAudio: "self_control_email",
            interruptionRange: 22.5...25.5,
            branches: [
                ScenarioBranch(userOption: "اللي سويته يحتاج شجاعة، مو ضعف.", narratorAudio: nil),
                ScenarioBranch(userOption: "ممكن كنت أقوى لو رديت.", narratorAudio: nil),
                ScenarioBranch(userOption: "السكوت دايمًا مو حل.", narratorAudio: nil)
            ]
        ),

        // -------------------- المستوى 4 --------------------
        Scenario(
            level: 4,
            title: "استقبال النقد",
            mainAudio: "feedback_fahad",
            interruptionRange: 25.0...28.0,
            branches: [
                ScenarioBranch(userOption: "يمكن طريقته كانت قاسية، بس فيها فرصة للتطور.", narratorAudio: nil),
                ScenarioBranch(userOption: "لا تسمع له، مدراؤنا دايم ينتقدون.", narratorAudio: nil),
                ScenarioBranch(userOption: "عادي، كلنا ننهان أحيان.", narratorAudio: nil)
            ]
        ),

        // -------------------- المستوى 5 --------------------
        Scenario(
            level: 5,
            title: "حل الخلافات – ريم",
            mainAudio: "conflict_reem",
            interruptionRange: 20.0...23.0,
            branches: [
                ScenarioBranch(userOption: "واضح أنك حاولت توصلين شعورك بلطف.", narratorAudio: nil),
                ScenarioBranch(userOption: "أحيانًا لازم نكون قاسين بعد.", narratorAudio: nil),
                ScenarioBranch(userOption: "لو سكتّي من البداية كان أفضل.", narratorAudio: nil)
            ]
        ),

        // -------------------- المستوى 6 --------------------
        Scenario(
            level: 6,
            title: "التكيّف مع التغيير",
            mainAudio: "change_ahmad",
            interruptionRange: 29.0...31.0,
            branches: [
                ScenarioBranch(userOption: "أحس بك، وتعب الفريق واضح. نقدر نلاقي حل وسط يساعدنا.", narratorAudio: "ahmad_response_1"),
                ScenarioBranch(userOption: "بالنهاية هذا شغل، وكلنا لازم نأقلم نفسنا مع التغييرات.", narratorAudio: "ahmad_response_2"),
                ScenarioBranch(userOption: "المفروض ما نحول الاجتماع لدراما، نركز على الحلول.", narratorAudio: "ahmad_response_3")
            ]
        ),

        // -------------------- المستوى 7 --------------------
        Scenario(
            level: 7,
            title: "اتخاذ قرار مبني على العاطفة",
            mainAudio: "decision_lama",
            interruptionRange: 34.5...38.0,
            branches: [
                ScenarioBranch(userOption: "تقييمك موزون، ما كان قاسي ولا متساهل.", narratorAudio: "lama_response_1"),
                ScenarioBranch(userOption: "كنت تقدر تفصل مشاعرك أكثر، التقييم لازم يكون مهني بحت.", narratorAudio: "lama_response_2"),
                ScenarioBranch(userOption: "يبدو إنك خفت تواجهها بالحقيقة.", narratorAudio: "lama_response_3")
            ]
        ),

        // -------------------- المستوى 8 --------------------
        Scenario(
            level: 8,
            title: "بناء الثقة – راجو",
            mainAudio: "trust_respect_raju",
            interruptionRange: 42.0...44.0,
            branches: [
                ScenarioBranch(userOption: "يا شباب، المزح شيء، بس مهم نحترم كل شخص في الفريق مهما كانت وظيفته.", narratorAudio: "raju_response_1"),
                ScenarioBranch(userOption: "ما يحتاج نبالغ، هو الموضوع خفيف ومزح بسيط.", narratorAudio: "raju_response_2"),
                ScenarioBranch(userOption: "خلوا الجو أخف، راجو أكيد فاهم إننا نمزح معاه.", narratorAudio: "raju_response_3")
            ]
        ),

        // -------------------- المستوى 9 --------------------
        Scenario(
            level: 9,
            title: "التحفيز الذاتي – فارس",
            mainAudio: "self_motivation_fares",
            interruptionRange: 38.0...41.0,
            branches: [
                ScenarioBranch(userOption: "إذا أحد ثاني مكانك، ما كان تحمّل ربع اللي سويته.", narratorAudio: "fares_response_1"),
                ScenarioBranch(userOption: "هو مديرك يمكن ما يقصد، بس فعلاً تأخرت بحل المشكلة.", narratorAudio: "fares_response_2"),
                ScenarioBranch(userOption: "لو تفكر تنقل مكان ثاني، يمكن ترتاح وتبدأ من جديد.", narratorAudio: "fares_response_3")
            ]
        ),

        // -------------------- المستوى 10 --------------------
        Scenario(
            level: 10,
            title: "المساءلة الذاتية – سارة",
            mainAudio: "accountability_sara",
            interruptionRange: 30.0...32.5,
            branches: [
                ScenarioBranch(userOption: "الكل يتحمّل جزء من اللي صار.", narratorAudio: "sara_response_1"),
                ScenarioBranch(userOption: "كان المفروض تراجع قبل العرض.", narratorAudio: "sara_response_2"),
                ScenarioBranch(userOption: "مو ذنبك، ما أحد وضّح شي.", narratorAudio: "sara_response_3")
            ]
        )
    ]

    func scenario(for level: Int) -> Scenario? {
        scenarios.first { $0.level == level }
    }
}
