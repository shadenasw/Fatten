//
//  Scenario.swift
//  Qiyam
//
//  Created by shaden  on 10/11/1446 AH.
//
import Foundation

struct TextScenarios {
    let level: Int
    let description: String
    let choices: [Choice]
    let imageName: String
}

struct Choice {
    let text: String
    let points: Int
}

let scenarios: [TextScenarios] = [
    TextScenarios(
        level: 1,
        description: "وصلت متأخر 10 دقايق على اجتماع الفريق بسبب زحمة مفاجئة. الكل شافك تدخل والمدير وقف شوي وانت داخل. وش تسوي؟",
        choices: [
            Choice(text: "تعتذر بسرعة قدام الكل وتوضح السبب بدون ما تدخل بتفاصيل كثيرة.", points: 10),
            Choice(text: "تعتذر بعد الاجتماع لمديرك بشكل شخصي وتشرح له الوضع.", points: 5),
            Choice(text: "تدخل بدون ما تقول شي عشان ما تقاطع الاجتماع.", points: 1)
        ]
        , imageName: "level1_image" // ← سمه زي ما تبغى
    ),
    TextScenarios(
        level: 2,
        description: "زميلك اليوم ساكت مو مثل عادته، ما دخل معكم لا بنقاش ولا حتى وقت الغداء. وش تسوي؟",
        choices: [
            Choice(text: "تجيبه على جنب وتقول له: \"لاحظت عليك اليوم إنك ساكت.. كل شي تمام؟\"", points: 10),
            Choice(text: "ترسل له رسالة خاصة آخر اليوم تسأله فيها إذا يحتاج شي.", points: 5),
            Choice(text: "تراقب الوضع يوم يومين وإذا استمر تسأله بعدين.", points: 1)
        ]
        , imageName: "level1_image" // ← سمه زي ما تبغى
    ),
    TextScenarios(
        level: 3,
        description: "مديرك قال: \"شغلك ممتاز، بس عندي بعض الملاحظات عشان نطور أكثر.\" زميلك الأصغر جاك وقال: \"أقدر تقول لي رأيك بصراحة؟\" وش تسوي؟",
        choices: [
            Choice(text: "تسمع لملاحظات مديرك وتقول له: \"شكرًا على الملاحظات، أكيد بشتغل عليها\"، وبعدها تعطي زميلك رأي صريح بطريقة راقية.", points: 10),
            Choice(text: "توضح لمديرك وجهة نظرك في الملاحظات وترد على زميلك بكلام عام.", points: 5),
            Choice(text: "تاخذ ملاحظات مديرك وبالنسبة لزميلك تقول له: \"شغلك كويس\" بدون تفاصيل.", points: 1)
        ]
        , imageName: "level1_image" // ← سمه زي ما تبغى
    ),
    TextScenarios(
        level: 4,
        description: "زميلك قال قدام الكل: \"فكرتك صراحة ما تستاهل نضيع وقتنا عليها.\" وش تسوي؟",
        choices: [
            Choice(text: "ترد بهدوء: \"أحترم رأيك، وخلينا نكمل النقاش ونشوف رأي الكل.\"", points: 10),
            Choice(text: "تبتسم وتقول: \"خلك إيجابي شوي، يمكن تطلع فكرة كويسة.\"", points: 5),
            Choice(text: "تسكت وقتها وتكلمه بعدين على جنب تقول له إن أسلوبه ما كان مناسب.", points: 1)
        ]
        ,imageName: "level1_image" // ← سمه زي ما تبغى
    ),
    TextScenarios(
        level: 5,
        description: "اتهمت زميلك إنه تأخر بالشغل، واكتشفت إن الغلط منك. زميلك زعلان والمدير عارف بالسالفة. وش تسوي؟",
        choices: [
            Choice(text: "تعتذر قدام زميلك والمدير وتعترف بخطأك وتوضح إنك حريص ما يتكرر.", points: 10),
            Choice(text: "تكلم زميلك على جنب وتعتذر له، وترسل إيميل توضح فيه للمدير الموقف.", points: 5),
            Choice(text: "تحاول تخفف الموضوع وتقول إنه كان سوء تفاهم بدون ما توضح تفاصيل.", points: 1)
        ]
        ,imageName: "level1_image"
    ),
    TextScenarios(
        level: 6,
        description: "فريقك تعبان وهو مهمل وما ينجز. الفريق متضايق وانت القائد. وش تسوي؟",
        choices: [
            Choice(text: "تكلمه على جنب وتوضح له أهمية شغله وتأثره على الفريق وتحط له خطة واضحة للإنجاز.", points: 10),
            Choice(text: "تكلم الفريق كامل وتوضح إن الشغل لازم يكون متساوي وتلمّح له بدون ما تسميه.", points: 5),
            Choice(text: "تبلغ المدير بالمشكلة عشان يتصرف.", points: 1)
        ]
        ,imageName: "level1_image"
    ),
    TextScenarios(
        level: 7,
        description: "تحس إنك ماخذ حقك بشغلك ومديرك ما يلاحظ. وش تسوي؟",
        choices: [
            Choice(text: "تحدد موعد مع مديرك وتتكلم بصراحة عن إحساسك وتطلب منه ملاحظات عملية تطورك.", points: 10),
            Choice(text: "تحاول تشتغل على نفسك أكثر عشان تبرز من غير ما تقول له شي.", points: 5),
            Choice(text: "تفضفض لزملاءك عن إحباطك وتستنى الوضع يتحسن لحاله.", points: 1)
        ]
        ,imageName: "level1_image"
    ),
    TextScenarios(
        level: 8,
        description: "زميلك يقول: \"سمعت عن فلان؟ عنده مشاكل مع الإدارة... وش رأيك؟\" وش ترد؟",
        choices: [
            Choice(text: "تقول: \"بصراحة ما لي دخل بهالمواضيع وأفضل نركز بشغلنا.\"", points: 10),
            Choice(text: "ترد: \"ما أدري، الله يعينه بس ما أحب أتكلم عن أحد.\"", points: 5),
            Choice(text: "تغيّر الموضوع وتقول: \"طيب خلونا نشوف الملفات اللي عندنا!\"", points: 1)
        ]
        ,imageName: "level1_image"
    ),
    TextScenarios(
        level: 9,
        description: "تحس بإرهاق شديد وكمان لاحظت زميلك نفس الحالة. وش تسوي؟",
        choices: [
            Choice(text: "تاخذ استراحة قصيرة وتتكلم مع مديرك عن ضغط الشغل وتطلب إعادة ترتيب المهام.", points: 10),
            Choice(text: "تتكلم مع زميلك وتسانده نفسيًا وتحاول تخففون عن بعض.", points: 5),
            Choice(text: "تكمل شغلك وتقول لنفسك: \"إن شاء الله تهون مع الوقت.\"", points: 1)
        ]
        ,imageName: "level1_image"
    ),
    TextScenarios(
        level: 10,
        description: "عضوين من الفريق يتجادلون: واحد يقول الجودة أهم، والثاني يقول الوقت أهم. وش تسوي؟",
        choices: [
            Choice(text: "تقول: \"خلونا نطلع بخطة توازن بين الجودة والموعد ونوزع المهام حسب أولويات كل طرف.\"", points: 10),
            Choice(text: "تهدي الوضع وتقول لهم تجتمعون على جنب تناقشون الموضوع براحة.", points: 5),
            Choice(text: "تاخذ القرار بنفسك وتفرض الخطة اللي تشوفها صح.", points: 1)
        ]
        ,imageName: "level1_image"
    )
]

