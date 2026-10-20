import 'package:flutter/widgets.dart';

import 'app_state.dart';

/// A string that carries both site languages.
class L10n {
  const L10n(this.zh, this.en);

  final String zh;
  final String en;

  String of(BuildContext context) => context.isZh ? zh : en;
}

class ServiceItem {
  const ServiceItem({
    required this.slug,
    required this.art,
    required this.panel,
    required this.panelAlt,
    required this.eyebrow,
    required this.name,
    required this.blurb,
    required this.deliverables,
    required this.action,
  });

  final String slug;
  final String art;

  /// Two stop colours for the artwork panel gradient.
  final int panel;
  final int panelAlt;
  final L10n eyebrow;
  final L10n name;
  final L10n blurb;
  final L10n deliverables;
  final L10n action;
}

class LibraryItem {
  const LibraryItem({
    required this.index,
    required this.art,
    required this.title,
    required this.blurb,
    required this.path,
  });

  final String index;
  final String art;
  final L10n title;
  final L10n blurb;
  final String path;
}

class StepItem {
  const StepItem({
    required this.index,
    required this.tag,
    required this.title,
    required this.sub,
  });

  final String index;
  final L10n tag;
  final L10n title;
  final L10n sub;
}

class NoteItem {
  const NoteItem({required this.title, required this.body});

  final L10n title;
  final L10n body;
}

class ProcessStep {
  const ProcessStep({
    required this.index,
    required this.title,
    required this.body,
    required this.output,
  });

  final String index;
  final L10n title;
  final L10n body;
  final L10n output;
}

class ServiceDetail {
  const ServiceDetail({
    required this.eyebrow,
    required this.title,
    required this.lead,
    required this.cta,
    required this.tags,
    required this.notesLabel,
    required this.notes,
    required this.processLabel,
    required this.process,
    required this.outcomeLabel,
    required this.outcomes,
    required this.closingTitle,
    required this.closingBody,
  });

  final L10n eyebrow;
  final L10n title;
  final L10n lead;
  final L10n cta;
  final L10n tags;
  final L10n notesLabel;
  final List<NoteItem> notes;
  final L10n processLabel;
  final List<ProcessStep> process;
  final L10n outcomeLabel;
  final List<NoteItem> outcomes;
  final L10n closingTitle;
  final L10n closingBody;
}

class LegalSection {
  const LegalSection({required this.title, required this.body});

  final L10n title;
  final L10n body;
}

/// All site copy, adapted for 春末夏初 with the English counterpart used for
/// the language toggle.
class SiteContent {
  static const brand = '春末夏初 / CHUNMO XIACHU';
  static const brandEn = 'CHUNMO XIACHU';

  static const pageTitle = L10n(
    '春末夏初｜企业 AI 科技公司',
    'CHUNMO XIACHU · Enterprise AI company',
  );
  static const businessWechatId = 'liangzhu2073';
  static const companyGithubUrl = 'https://github.com/chunmoxiachu';
  static const companyGithubLabel = 'GitHub · chunmoxiachu';

  static const navServices = L10n('服务', 'Services');
  static const navLibrary = L10n('内容与学习', 'Read / Learn');
  static const navContact = L10n('联系', 'Contact');
  static const navAbout = L10n('关于与联系', 'About & contact');
  static const navPrivacy = L10n('隐私说明', 'Privacy');
  static const navTerms = L10n('使用说明', 'Terms');
  static const navHome = L10n('回到首页', 'Back home');
  static const navMenu = L10n('打开菜单', 'Open menu');
  static const navClose = L10n('关闭菜单', 'Close menu');
  static const backTop = L10n('回到顶部', 'Back to top');
  static const exploreFurther = L10n('继续探索', 'Explore further');

  // ---------------------------------------------------------------- hero
  static const heroRole = L10n(
    'AI 架构与产品落地\n全栈工程交付',
    'AI architecture & product delivery\nFull-stack engineering',
  );
  static const heroPhilosophy = L10n(
    '从业务痛点出发，\n把下一步做出来。',
    'Start from real pain points.\nBuild the next step.',
  );
  static const heroBio = L10n(
    '春末夏初是一家专注企业 AI 的科技公司。我们把产品判断、工程实现与交付能力放在同一个团队里，从真实业务问题出发，把 AI 做成能上线、能使用、能持续迭代的系统。',
    'Chunmo Xiachu is a technology company focused on putting AI to work in real businesses. We bring product thinking, engineering and delivery into one team\u2014turning real business problems into AI systems that ship, get used and keep improving.',
  );
  static const heroBioShort = L10n(
    '专注企业 AI 的科技公司。\n从业务问题出发，交付可运行的 AI 系统。',
    'Enterprise AI delivery company.\nReal business problems, working systems.',
  );
  static const heroHeadline = L10n('把 AI|用进|真实业务', 'PUT AI|TO WORK|IN YOUR BUSINESS');
  static const heroCta = L10n('探索合作方式', 'Explore collaboration');
  static const heroSticker = L10n('CX / 26', 'CX / 26');

  // --------------------------------------------------------------- about
  static const aboutKicker = L10n('关于公司', 'About the company');
  static const aboutTagline = L10n('让 AI 进入业务现场。', 'AI into the real world.');
  static const aboutEyebrow = L10n('关于春末夏初', 'About Chunmo Xiachu');
  static const aboutTitle = L10n(
    '把 AI 从概念，做成企业真正能用的系统。',
    'From AI concept to systems your business can actually run.',
  );
  static const aboutBody1 = L10n(
    '春末夏初聚焦企业 AI 咨询、团队培训与 FDE 落地。我们不从工具清单出发，而是先理解业务流程、组织能力与真实约束，再决定技术路径。',
    'Chunmo Xiachu works across enterprise AI consulting, team training and forward-deployed delivery. We start with business processes, team capabilities and real constraints\u2014not a list of tools.',
  );
  static const aboutBody2 = L10n(
    '从方案、开发到培训与交接，我们以可运行的成果作为交付标准。',
    'From planning and development to training and handover, our standard is working delivery.',
  );
  static const aboutLinkStory = L10n('了解公司', 'About the company');
  static const aboutLinkServices = L10n('查看服务', 'Explore services');

  // ------------------------------------------------------------ services
  static const servicesLabel = L10n('服务', 'Services');
  static const servicesTitle = L10n('你需要哪一种支持？', 'What kind of support do you need?');
  static const servicesLead = L10n(
    '理清方向、让团队学会实操，或由我们的交付团队进入业务现场推进落地。三项服务可独立选择。',
    'Clarify direction, build hands-on capability, or bring our delivery team into the business. Choose any service independently.',
  );
  static const servicesOutcomeLabel = L10n('你会得到', 'What you leave with');

  static const services = <ServiceItem>[
    ServiceItem(
      slug: 'consulting',
      art: 'assets/brand/consulting.webp',
      panel: 0xFFC8F62A,
      panelAlt: 0xFFB7EE12,
      eyebrow: L10n('咨询', 'Consulting'),
      name: L10n('咨询', 'Consulting'),
      blurb: L10n(
        '围绕你的业务背景和具体问题，一起理清 AI 能做什么、有哪些选择，以及下一步从哪里开始。',
        'Work through your business context and questions to understand where AI can help, compare options and decide where to start.',
      ),
      deliverables: L10n('问题梳理 · 方案判断 · 下一步行动', 'Problem clarity · Options · Next steps'),
      action: L10n('了解咨询', 'Explore consulting'),
    ),
    ServiceItem(
      slug: 'training',
      art: 'assets/brand/training.webp',
      panel: 0xFFBBD8F5,
      panelAlt: 0xFFA9CCF0,
      eyebrow: L10n('培训', 'Training'),
      name: L10n('培训', 'Training'),
      blurb: L10n(
        '先了解企业现状和业务痛点，定制 1–3 天 AI 实战培训，结合业务实践、成果验收与后续追踪。',
        'Understand business pain points, tailor 1\u20133 days of AI training, and support practice, outcome review and follow-up.',
      ),
      deliverables: L10n(
        '定制培训方案 + 业务实践成果 + 后续追踪',
        'Tailored programme + practice outputs + follow-up',
      ),
      action: L10n('了解培训', 'Explore training'),
    ),
    ServiceItem(
      slug: 'fde',
      art: 'assets/brand/fde.webp',
      panel: 0xFFDCD8F2,
      panelAlt: 0xFFC9C4EC,
      eyebrow: L10n('FDE 落地', 'FDE delivery'),
      name: L10n('FDE 落地', 'FDE delivery'),
      blurb: L10n(
        '进入企业业务现场，梳理痛点与卡点，制定对应方案并开发落地，带团队培训实训，完成验收交接。',
        'Work inside the business, map blockers, design and develop matched solutions, train the team and complete acceptance and handover.',
      ),
      deliverables: L10n(
        '生产可运行的系统源码 + 完整交接文档',
        'Production-ready source code + complete handover documentation',
      ),
      action: L10n('了解 FDE 落地', 'Explore FDE delivery'),
    ),
  ];

  // ------------------------------------------------------------- library
  static const libraryLabel = L10n('内容与学习', 'Read / Learn / Build');
  static const libraryTitle = L10n('公司实践，行业观察。', 'What we build. What we learn.');

  static const library = <LibraryItem>[
    LibraryItem(
      index: '01',
      art: 'assets/brand/content/global-v1.webp',
      title: L10n('出海实录', 'Building globally'),
      blurb: L10n(
        '从第一个站到 AI 产品，记录项目进展、真实经历与复盘。',
        'Launches, costs, setbacks and product decisions, recorded along the way.',
      ),
      path: '/go-global',
    ),
    LibraryItem(
      index: '02',
      art: 'assets/brand/content/learn-v1.webp',
      title: L10n('系统学 AI', 'Learn AI systematically'),
      blurb: L10n(
        '40 篇完整教程：懂原理、会使用、能判断，按顺序学起来。',
        'A complete 40-lesson curriculum: understand, use and evaluate AI.',
      ),
      path: '/learn-ai',
    ),
    LibraryItem(
      index: '03',
      art: 'assets/brand/content/geo-v1.webp',
      title: L10n('GEO 企业实战', 'GEO field guide'),
      blurb: L10n(
        '完整专栏：企业判断、关键词与信源、内容建设、实施和监测排障。',
        'The complete guide to evaluation, keywords, sources, content, implementation and monitoring.',
      ),
      path: '/geo-wiki',
    ),
    LibraryItem(
      index: '04',
      art: 'assets/brand/content/writing-v1.webp',
      title: L10n('思考与随笔', 'Notes & reflections'),
      blurb: L10n(
        '记录 AI、产品与创业路上的观察、尝试和复盘。',
        'Observations, experiments and reflections on AI, products and entrepreneurship.',
      ),
      path: '/blog',
    ),
  ];

  // -------------------------------------------------------------- method
  static const methodLabel = L10n('我们的方法', 'How we work');
  static const methodTitleA = L10n('从真实\n问题\n出发', 'START WITH\nA REAL\nPROBLEM');
  static const methodTitleB = L10n('让人\n用得上\n接得住', 'BUILT TO USE.\nREADY TO\nHAND OVER.');
  static const methodStepsLabel = L10n('四个做事步骤', 'Four practical steps');

  static const methodSteps = <StepItem>[
    StepItem(
      index: '01',
      tag: L10n('结果', 'Outcome'),
      title: L10n('先明确结果', 'Define the outcome.'),
      sub: L10n('再选择工具', 'Then choose the tools.'),
    ),
    StepItem(
      index: '02',
      tag: L10n('边界', 'Scope'),
      title: L10n('把目标理清', 'Clarify the goal.'),
      sub: L10n('把边界定明', 'Set clear boundaries.'),
    ),
    StepItem(
      index: '03',
      tag: L10n('验证', 'Validate'),
      title: L10n('小步验证', 'Validate in small steps.'),
      sub: L10n('按反馈推进', 'Build on real feedback.'),
    ),
    StepItem(
      index: '04',
      tag: L10n('交付', 'Deliver'),
      title: L10n('交付即生产', 'Built for production.'),
      sub: L10n('交接无黑盒', 'Handed over without black boxes.'),
    ),
  ];

  // ------------------------------------------------------------- contact
  static const contactEyebrow = L10n('联系', 'Contact');
  static const contactTitle = L10n('让 AI 成为企业的生产力。', 'Make AI part of how your business works.');
  static const contactBody = L10n(
    '无论是评估方向、团队培训还是系统落地，先告诉我们贵司的业务场景和当前卡点。我们会从最具体的问题开始。',
    'Whether you are evaluating direction, training a team or delivering a system, start with your business context and current blocker. We begin with the most concrete problem.',
  );
  static const contactCta = L10n('联系商务团队', 'Contact our team');
  static const contactScan = L10n('扫码添加商务微信', 'Scan for business WeChat');
  static const contactWechat = L10n('商务微信 / WECHAT', 'Business WeChat');
  static const contactCopy = L10n('复制商务微信', 'Copy business WeChat');
  static const contactCopied = L10n('已复制商务微信', 'Business WeChat copied');
  static const copyright = L10n('春末夏初 © 2026', 'CHUNMO XIACHU © 2026');
  static const closingTitle = L10n('从一个真实业务问题开始', 'Start with a real business problem');
  static const closingBody = L10n(
    '告诉我们贵司的业务、现在卡在哪里，以及想做到什么。我们从眼前最具体的问题开始。',
    'Tell us about your business, where it is stuck and what you want to achieve. We start from the most concrete question in front of you.',
  );

  // ------------------------------------------------------- about page
  static const aboutPageEyebrow = L10n('关于公司与联系', 'About & contact');
  static const aboutPageTitle = L10n('懂业务，也懂工程。\n把 AI 推到生产环境。', 'Business context.\nEngineering that ships.');
  static const aboutPageLead = L10n(
    '春末夏初是一家专注企业 AI 的科技公司。我们把产品判断、工程实现与交付能力放在同一个团队里，从真实业务问题出发，把 AI 做成能上线、能使用、能持续迭代的系统。',
    'Chunmo Xiachu is a technology company focused on putting AI to work in real businesses. We bring product thinking, engineering and delivery into one team\u2014turning real business problems into AI systems that ship, get used and keep improving.',
  );
  static const companyFacts = <(L10n, L10n)>[
    (L10n('服务范围', 'What we do'), L10n('AI 咨询 / 企业培训 / FDE 交付', 'AI consulting / team training / FDE delivery')),
    (L10n('合作方式', 'How we engage'), L10n('诊断 → 方案 → 开发 → 实训 → 交接', 'Diagnose → plan → build → train → hand over')),
    (L10n('交付标准', 'Delivery standard'), L10n('可运行 / 可验收 / 可维护', 'Running / accepted / maintainable')),
  ];
  static const aboutPageFacts = <NoteItem>[
    NoteItem(
      title: L10n('企业 AI 落地公司', 'An enterprise AI delivery company'),
      body: L10n('聚焦 AI 咨询、团队培训与 FDE 落地，把 AI 能力带进真实业务流程。', 'Focused on AI consulting, team training and FDE delivery that reaches real business workflows.'),
    ),
    NoteItem(
      title: L10n('产品与工程一体', 'Product and engineering in one team'),
      body: L10n('从业务判断、架构设计到开发交付，由同一团队持续推进。', 'One team carries the work from business framing and architecture through development and delivery.'),
    ),
    NoteItem(
      title: L10n('以可运行为标准', 'Built to run'),
      body: L10n('交付生产可用的系统、文档与团队能力，而不是停留在演示。', 'We deliver production-ready systems, documentation and team capability\u2014not a demo.'),
    ),
  ];

  // ----------------------------------------------------- service detail
  static const serviceDetails = <String, ServiceDetail>{
    'consulting': ServiceDetail(
      eyebrow: L10n('AI 咨询 · 先免费聊聊', 'AI consulting · start with a free chat'),
      title: L10n('你的 AI 问题，\n一起聊清楚。', 'Your AI question,\nworked through together.'),
      lead: L10n(
        'AI 用在哪、工具怎么选、项目卡在哪？带上你的业务背景和具体问题，一起理清思路与下一步。',
        'Where AI fits, which tools to pick, why the project is stuck\u2014bring your context and questions and we will map the options and the next step.',
      ),
      cta: L10n('加微信，免费聊聊', 'Add WeChat, chat for free'),
      tags: L10n('企业 AI 咨询 · 业务场景导向\n围绕真实问题展开交流', 'Enterprise AI consulting · business-led\nGrounded in your real operations'),
      notesLabel: L10n('带着这些问题，来聊聊', 'Bring questions like these'),
      notes: [
        NoteItem(
          title: L10n('AI 想法值不值得做', 'Is the AI idea worth building?'),
          body: L10n('聊用户需求、关键假设，以及先试哪一步。', 'Talk through user needs, key assumptions and the smallest first step.'),
        ),
        NoteItem(
          title: L10n('模型和工具怎么选', 'Which model or tool fits?'),
          body: L10n('结合你的任务，聊选择理由、成本和限制。', 'Reasons, costs and limits, tied to your actual tasks.'),
        ),
        NoteItem(
          title: L10n('项目卡住，下一步怎么走', 'Stuck project, next move?'),
          body: L10n('一起拆开当前问题，讨论可行的推进方式。', 'Break the current problem apart and compare viable paths.'),
        ),
      ],
      processLabel: L10n('从加微信，到把问题聊清楚', 'From a WeChat message to a clear plan'),
      process: [
        ProcessStep(
          index: '01',
          title: L10n('说说你的问题', 'Describe the problem'),
          body: L10n('加微信，发来业务背景和当前卡点。文字交流免费。', 'Send your business context and the current blocker. Text chat is free.'),
          output: L10n('文字交流 · 免费', 'Text chat · free'),
        ),
        ProcessStep(
          index: '02',
          title: L10n('约个时间', 'Book a slot'),
          body: L10n('确认想聊的重点后，一起约个方便的时间，用语音或电话深入聊聊。', 'Once the focus is clear, pick a time for a call or voice session.'),
          output: L10n('语音 / 电话 · ¥29 起', 'Voice / call · from ¥29'),
        ),
        ProcessStep(
          index: '03',
          title: L10n('一起理清下一步', 'Agree the next step'),
          body: L10n('用 15–30 分钟聚焦重点问题，讨论可行的行动。', '15\u201330 minutes on the questions that matter, ending with actions.'),
          output: L10n('下一步行动清单', 'A short action list'),
        ),
      ],
      outcomeLabel: L10n('聊完，你会更清楚', 'After the call you will know'),
      outcomes: [
        NoteItem(
          title: L10n('问题到底卡在哪', 'Where the problem really sits'),
          body: L10n('哪些事实已知，哪些还需要验证。', 'Which facts are known and which still need validation.'),
        ),
        NoteItem(
          title: L10n('有哪些可选做法', 'Which options exist'),
          body: L10n('不同做法的取舍，以及适合你的原因。', 'Trade-offs between options and why one fits you.'),
        ),
        NoteItem(
          title: L10n('下一步可以先试什么', 'What to try first'),
          body: L10n('结合当次讨论，明确一个可尝试的方向。', 'One concrete direction to test next.'),
        ),
      ],
      closingTitle: L10n('从一个真实问题开始', 'Start from a real problem'),
      closingBody: L10n(
        '带着一个具体问题来。不用准备正式文档，说清项目背景和最想问的问题就可以。',
        'Bring one specific question. No formal document needed\u2014context plus the question you most want answered is enough.',
      ),
    ),
    'training': ServiceDetail(
      eyebrow: L10n('AI 实战培训', 'Hands-on AI training'),
      title: L10n('围绕企业痛点，\n定制 AI 实战培训。', 'AI training built\naround your pain points.'),
      lead: L10n(
        '先了解企业现状，再定制通常为 1–3 天的培训；围绕业务开展教学与实践，验收成果，并在约定范围内持续跟进。',
        'Start with a diagnosis, then a tailored 1\u20133 day programme: teaching and practice on real business work, outcome review and follow-up.',
      ),
      cta: L10n('聊聊企业的培训需求', 'Discuss your training needs'),
      tags: L10n('企业定制 · 通常 1–3 天 · 线上 / 线下', 'Tailored · usually 1\u20133 days · online / on-site'),
      notesLabel: L10n('把学习，放进这些真实任务', 'Learning that lands in real tasks'),
      notes: [
        NoteItem(
          title: L10n('知道工具，但不会用于工作', 'Knows the tools, not the workflow'),
          body: L10n('选一个具体任务，拆出可以用 AI 帮忙的步骤。', 'Pick one task and break out the steps AI can support.'),
        ),
        NoteItem(
          title: L10n('团队需要统一操作方法', 'The team needs one method'),
          body: L10n('共同练习，明确输入材料、操作步骤和检查方法。', 'Practise together and agree inputs, steps and checks.'),
        ),
        NoteItem(
          title: L10n('学过之后，还做不出结果', 'Trained, still no output'),
          body: L10n('用新的材料再做一遍，检查哪里还需要补练。', 'Run it again on fresh material and fill the gaps.'),
        ),
      ],
      processLabel: L10n('从企业诊断，到培训后的持续应用', 'From diagnosis to everyday use'),
      process: [
        ProcessStep(
          index: '01',
          title: L10n('了解企业现状', 'Understand the business'),
          body: L10n('先了解业务流程、团队岗位、现有工具和 AI 使用情况，找出当前的痛点与优先事项。', 'Map processes, roles, tooling and current AI usage to find priorities.'),
          output: L10n('企业现状与痛点清单', 'Context & pain point list'),
        ),
        ProcessStep(
          index: '02',
          title: L10n('定制培训方案', 'Design the programme'),
          body: L10n('根据企业情况和痛点设计培训内容，通常安排 1–3 天；提前确认参训岗位、实操场景与预期成果。', 'Design 1\u20133 days around your pain points; confirm roles, scenarios and expected outcomes.'),
          output: L10n('定制课程与 1–3 天安排', 'Tailored curriculum & schedule'),
        ),
        ProcessStep(
          index: '03',
          title: L10n('开展定制培训', 'Deliver the training'),
          body: L10n('围绕约定的业务场景讲解和演示，将工具选择、操作方法与检查标准教给团队。', 'Teach tool choice, method and quality checks on agreed scenarios.'),
          output: L10n('培训材料与操作示例', 'Materials & worked examples'),
        ),
        ProcessStep(
          index: '04',
          title: L10n('业务实践与验收', 'Practice & acceptance'),
          body: L10n('团队用真实或脱敏材料动手实践，现场辅导、纠偏，按事前约定的标准检查成果。', 'Teams practise on real or anonymised material, coached on site and checked against agreed standards.'),
          output: L10n('实践成果与验收记录', 'Practice outputs & review notes'),
        ),
        ProcessStep(
          index: '05',
          title: L10n('后续追踪与服务', 'Follow-up support'),
          body: L10n('培训后跟进实际使用情况，收集落地中的问题，提供约定范围内的答疑与后续支持。', 'Track real usage, collect blockers and answer questions within the agreed scope.'),
          output: L10n('跟进记录与后续行动', 'Follow-up log & next actions'),
        ),
      ],
      outcomeLabel: L10n('让团队会用 AI，让业务更高效', 'A team that uses AI, a business that moves faster'),
      outcomes: [
        NoteItem(
          title: L10n('掌握 AI 的基本应用', 'Practical AI basics'),
          body: L10n('能选择合适的工具、给出清晰指令、检查输出，把 AI 用于资料整理、内容写作、数据分析等日常任务。', 'Choose tools, write clear instructions and check output for research, writing and analysis.'),
        ),
        NoteItem(
          title: L10n('把个人技巧变成团队流程', 'From personal tricks to team process'),
          body: L10n('把输入材料、操作步骤和检查标准整理成可复用的工作流程，让同事能照着做。', 'Turn inputs, steps and checks into a repeatable workflow colleagues can follow.'),
        ),
        NoteItem(
          title: L10n('让重复任务逐步自动化', 'Automate repetitive work'),
          body: L10n('识别适合自动化的环节，动手练习串联工具，让资料处理、信息汇总等重复工作减少人工操作。', 'Spot automatable steps and chain tools to cut manual handling.'),
        ),
        NoteItem(
          title: L10n('把降本增效落到具体任务', 'Measure impact on real tasks'),
          body: L10n('比较使用 AI 前后的耗时、人工投入和结果质量，找到值得继续推广的场景。', 'Compare time, effort and quality before and after, and scale what works.'),
        ),
      ],
      closingTitle: L10n('从一个真实问题开始', 'Start from a real problem'),
      closingBody: L10n(
        '先聊聊企业现状和业务痛点：参训岗位和人数、现有工具基础，以及可用于实操的脱敏材料。',
        'Tell us the current pain points, which roles will join, the tooling baseline and what anonymised material is available for practice.',
      ),
    ),
    'fde': ServiceDetail(
      eyebrow: L10n('FDE · 产品落地', 'FDE · forward deployed engineering'),
      title: L10n('把 AI 需求，\n做成可用的成果。', 'Turn an AI need\ninto working delivery.'),
      lead: L10n(
        '先进入企业了解情况，梳理痛点与卡点，再提出逐项对应的方案。确认后开发，带团队培训与实训，最后验收交接。',
        'Our team works inside the business, maps the blockers, proposes a matched plan per problem, then builds, trains your team and hands over.',
      ),
      cta: L10n('说说你想做成什么', 'Tell us what to build'),
      tags: L10n('企业诊断 / 方案 / 开发 / 实训 / 交接', 'Diagnosis / plan / build / practice / handover'),
      notesLabel: L10n('这些业务问题，可以一起做出来', 'Problems worth building for'),
      notes: [
        NoteItem(
          title: L10n('想减少重复的手工处理', 'Cut manual, repetitive handling'),
          body: L10n('梳理现有流程，确认自动处理和人工确认的边界。', 'Map the current flow and agree the boundary between automation and human checks.'),
        ),
        NoteItem(
          title: L10n('已有原型，需要接入业务', 'A prototype that must join the business'),
          body: L10n('用真实样本验证，再补齐集成、异常处理和部署。', 'Validate on real samples, then complete integration, error handling and deployment.'),
        ),
        NoteItem(
          title: L10n('想给现有系统增加 AI 能力', 'Add AI to an existing system'),
          body: L10n('检查接口、数据和权限条件，分阶段开发与验证。', 'Check APIs, data and permissions, then build and verify in phases.'),
        ),
      ],
      processLabel: L10n('从企业现状，到验收交接', 'From current state to signed-off handover'),
      process: [
        ProcessStep(
          index: '01',
          title: L10n('入驻了解企业', 'Deploy into the business'),
          body: L10n('进入企业的业务现场，与负责人和使用团队沟通，了解流程、系统、数据及协作条件。', 'Meet owners and users on site and learn the processes, systems, data and constraints.'),
          output: L10n('企业现状与业务流程记录', 'Context & process notes'),
        ),
        ProcessStep(
          index: '02',
          title: L10n('梳理痛点与卡点', 'Map pain points & blockers'),
          body: L10n('结合现状梳理低效环节、重复工作和落地障碍，明确问题成因、优先级及约束。', 'Identify slow spots, duplicated work and delivery blockers, with causes, priority and constraints.'),
          output: L10n('问题清单与优先级', 'Problem list & priorities'),
        ),
        ProcessStep(
          index: '03',
          title: L10n('制定对应方案', 'Propose matched plans'),
          body: L10n('逐项对应业务问题提出解决方案，明确技术路径、实施范围、阶段安排与验收标准。', 'A plan per problem: technical path, scope, phases and acceptance criteria.'),
          output: L10n('问题与方案对照表', 'Problem-to-plan mapping'),
        ),
        ProcessStep(
          index: '04',
          title: L10n('确认后开发', 'Build after sign-off'),
          body: L10n('与企业确认方案、范围、资源和交付安排后，开展开发与系统接入，分阶段验证实际效果。', 'Once scope, resources and delivery are agreed, build, integrate and verify in stages.'),
          output: L10n('确认方案与可运行成果', 'Agreed plan & running system'),
        ),
        ProcessStep(
          index: '05',
          title: L10n('培训与业务实训', 'Train & rehearse'),
          body: L10n('向使用和维护团队讲解系统操作，在真实或脱敏业务场景中实训，解决使用中的问题。', 'Teach users and maintainers, then rehearse on real or anonymised business scenarios.'),
          output: L10n('培训材料与实训记录', 'Training material & rehearsal log'),
        ),
        ProcessStep(
          index: '06',
          title: L10n('验收与交接', 'Acceptance & handover'),
          body: L10n('实训完成后，按约定标准验收，交接约定范围内的源码、文档、权限和维护职责。', 'Review against the agreed standard and hand over code, docs, access and maintenance duties.'),
          output: L10n('验收记录与交接清单', 'Acceptance record & handover list'),
        ),
      ],
      outcomeLabel: L10n('让 AI 落地，带来实际业务改善', 'AI in production, with measurable effect'),
      outcomes: [
        NoteItem(
          title: L10n('减少重复操作，把时间还给业务', 'Give time back to the business'),
          body: L10n('将适合的资料整理、信息录入与汇总环节交给 AI 或自动化处理，减少重复劳动。', 'Move suitable collation, entry and summarising work to automation.'),
        ),
        NoteItem(
          title: L10n('关键流程衔接更顺畅', 'Smoother hand-offs'),
          body: L10n('围绕实际卡点接通系统和业务步骤，减少跨岗位的反复传递与等待。', 'Connect systems and steps around the real blockers, cutting back-and-forth.'),
        ),
        NoteItem(
          title: L10n('信息更好找，判断更有依据', 'Findable information, grounded decisions'),
          body: L10n('在约定场景中整合分散的业务信息，让团队更快查找、核对和使用资料。', 'Consolidate scattered information so teams can find, check and use it faster.'),
        ),
        NoteItem(
          title: L10n('团队会用，日常用得起来', 'Adopted in daily work'),
          body: L10n('让工具融入日常工作，通过真实场景实训，让使用者能独立操作、检查结果和处理常见问题。', 'Through real-scenario practice, users operate, check and troubleshoot independently.'),
        ),
        NoteItem(
          title: L10n('改善有依据，投入有方向', 'Evidence for the next investment'),
          body: L10n('比较落地前后的任务耗时、人工投入与结果质量，验证哪些环节得到改善。', 'Compare time, effort and quality before and after to validate the improvement.'),
        ),
        NoteItem(
          title: L10n('业务变化时，系统跟得上', 'A system that keeps up'),
          body: L10n('让维护团队理解系统的关键环节和使用边界，能定位常见问题、调整约定范围内的流程。', 'Maintainers understand the critical parts and can adjust agreed flows themselves.'),
        ),
      ],
      closingTitle: L10n('从一个真实问题开始', 'Start from a real problem'),
      closingBody: L10n(
        '聊聊你想做成的事：企业业务与当前流程、主要痛点与卡点、涉及的系统和数据，以及参与确认、实训和验收的人员。',
        'Describe the process, the main blockers, the systems and data involved, and who joins acceptance and handover.',
      ),
    ),
  };

  // -------------------------------------------------------------- legal
  static const privacySections = <LegalSection>[
    LegalSection(
      title: L10n('浏览器里保存了什么？', 'What is stored in your browser?'),
      body: L10n(
        '语言和明暗主题保存在你的浏览器本地。合作需求草稿保存在当前浏览器会话中，读取时只恢复最近 24 小时内的草稿。你可以通过浏览器设置清除这些数据。',
        'Language and colour theme are stored locally in your browser. Collaboration drafts live in the current browser session and only drafts from the last 24 hours are restored. You can clear this data in your browser settings.',
      ),
    ),
    LegalSection(
      title: L10n('阅读密码如何使用？', 'How are reading passwords used?'),
      body: L10n(
        '阅读密码通过本站的 HTTPS 接口验证。验证成功后，浏览器保存最长 30 天的签名授权 Cookie，用于访问受保护内容；该 Cookie 不包含阅读密码。清除本站 Cookie 会结束授权。',
        'Reading passwords are verified over HTTPS. After a successful check the browser stores a signed authorisation cookie for up to 30 days to access protected content; the cookie never contains the password. Clearing site cookies ends the authorisation.',
      ),
    ),
    LegalSection(
      title: L10n('需求会自动发送吗？', 'Are requests sent automatically?'),
      body: L10n(
        '需求表单用于在浏览器里整理和生成合作摘要，不会自动把表单发送给春末夏初。复制摘要后，你自行决定通过微信等渠道发送哪些信息。请不要在需求摘要中填写密码、密钥或与合作无关的敏感信息。',
        'The request form only composes a summary inside your browser; nothing is sent automatically. After copying the summary you decide what to share through WeChat or any other channel. Please do not include passwords, keys or unrelated sensitive data.',
      ),
    ),
    LegalSection(
      title: L10n('访问和外部链接', 'Visits and external links'),
      body: L10n(
        '本站通过 Cloudflare 托管，请求处理会涉及 IP、浏览器及请求信息。外部链接（例如 X）和微信由各平台按其规则处理你主动提交的信息。',
        'The site is hosted on Cloudflare, so requests involve IP, browser and request information. External links such as X and WeChat handle the information you submit under their own rules.',
      ),
    ),
    LegalSection(
      title: L10n('如何联系？', 'How to get in touch?'),
      body: L10n(
        '如需咨询本站数据处理或联系信息相关问题，请通过关于与联系页面的微信 liangzhu2073 联系春末夏初。',
        'For questions about data handling or contact details, reach Chunmo Xiachu on WeChat: liangzhu2073.',
      ),
    ),
  ];

  static const termsSections = <LegalSection>[
    LegalSection(
      title: L10n('谁在提供这些内容？', 'Who provides this content?'),
      body: L10n(
        '本站由春末夏初维护，分享团队的 AI、产品和业务实践。文章中的历史项目及数据以原发表时间和具体上下文为准。',
        'This site is maintained by Chunmo Xiachu and shares our AI, product and business practice. Historical projects and figures are accurate as of their original publication context.',
      ),
    ),
    LegalSection(
      title: L10n('引用与素材来源', 'Citations and sources'),
      body: L10n(
        '引用文章时请注明春末夏初、文章标题与原文链接。第三方引用、软件、字体及素材保留其原有许可和来源；本站发布不意味着第三方素材可以任意再分发。',
        'When quoting, credit Chunmo Xiachu, the article title and the original link. Third-party references, software, fonts and assets keep their own licences; publication here does not permit redistribution.',
      ),
    ),
    LegalSection(
      title: L10n('密码保护内容', 'Password protected content'),
      body: L10n(
        '课程及标为受保护的专栏仅供取得阅读授权的读者访问，请勿分享阅读密码、批量复制或公开传播受保护正文和图片。',
        'Courses and protected columns are for authorised readers only. Do not share reading passwords or redistribute protected text and images.',
      ),
    ),
    LegalSection(
      title: L10n('内容与服务边界', 'Content and service boundaries'),
      body: L10n(
        '文章用于经验分享，不构成效果保证。咨询、培训和 FDE 的具体范围、费用、验收和后续支持以双方实际确认的安排为准；网站介绍不会自动生成合作订单。',
        'Articles share experience and are not a guarantee of results. Scope, fees, acceptance and support for consulting, training and FDE are set by mutual agreement; the site itself creates no order.',
      ),
    ),
    LegalSection(
      title: L10n('反馈与更正', 'Feedback and corrections'),
      body: L10n(
        '如发现内容错误、引用或授权问题，请通过关于与联系页面反馈，并附上具体页面和相关信息。',
        'If you spot an error or a citation/licensing issue, get in touch with the specific page and details.',
      ),
    ),
  ];

  // -------------------------------------------------------- library pages
  static const collectionEyebrow = L10n('内容与学习', 'Read / Learn / Build');
  static const collectionOthers = L10n('其他栏目', 'Other sections');
  static const collectionNote = L10n(
    '这一栏目正在持续整理，先看看其他内容，或者直接聊聊你的问题。',
    'This section is still being written up. Browse the others, or simply bring your question.',
  );

  // --------------------------------------------------------- legal pages
  static const legalIntroPrivacy = L10n(
    '简单说明本站如何处理浏览器数据、阅读权限与外部链接。',
    'A short note on browser storage, reading access and external links.',
  );
  static const legalIntroTerms = L10n(
    '简单说明内容来源、引用方式与服务边界。',
    'A short note on sources, citation and the boundaries of these services.',
  );
  static const legalUpdated = L10n('更新于 2026 年', 'Updated 2026');

  // ------------------------------------------------------------- not found
  static const notFoundEyebrow = L10n('404 · 页面未找到', '404 · Not found');
  static const notFoundTitle = L10n('这个页面不存在。', 'This page does not exist.');
  static const notFoundBody = L10n(
    '链接可能已经更新或移动。可以从下面的入口继续浏览。',
    'The link may have been moved or updated. Continue from one of these entries.',
  );

  static const libraryPages = <String, NoteItem>{
    '/go-global': NoteItem(
      title: L10n('出海实录', 'Building globally'),
      body: L10n(
        '从第一个站到 AI 产品，记录项目进展、真实经历与复盘。',
        'Launches, costs, setbacks and product decisions, recorded along the way.',
      ),
    ),
    '/learn-ai': NoteItem(
      title: L10n('系统学 AI', 'Learn AI systematically'),
      body: L10n(
        '40 篇完整教程：懂原理、会使用、能判断，按顺序学起来。',
        'A complete 40-lesson curriculum: understand, use and evaluate AI.',
      ),
    ),
    '/geo-wiki': NoteItem(
      title: L10n('GEO 企业实战', 'GEO field guide'),
      body: L10n(
        '完整专栏：企业判断、关键词与信源、内容建设、实施和监测排障。',
        'The complete guide to evaluation, keywords, sources, content, implementation and monitoring.',
      ),
    ),
    '/blog': NoteItem(
      title: L10n('思考与随笔', 'Notes & reflections'),
      body: L10n(
        '记录 AI、产品与创业路上的观察、尝试和复盘。',
        'Observations, experiments and reflections on AI, products and entrepreneurship.',
      ),
    ),
  };
}
