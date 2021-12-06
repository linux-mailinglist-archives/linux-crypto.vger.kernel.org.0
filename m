Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2346A49D
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Dec 2021 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhLFSd3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 6 Dec 2021 13:33:29 -0500
Received: from mail-bn8nam11hn2214.outbound.protection.outlook.com ([52.100.171.214]:62743
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230448AbhLFSd3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 6 Dec 2021 13:33:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyt3cIgm620f58SbddrRtdOIs+jVVa6qBLs5mBfi7wnSUyB4x4t4IPegnStyKWj4eoW5crZIA3HX/fiHB9nRMSl+H7jSOoqVIfQ9HcGu3gN5JJODKAdBOnWi4qIWVsTHnjhLsQukfbLIOYnQ3HIMZkxAfnwV07JTy3AYBB+B6Q9HiMqutR5MRXRQbDnZ0/JS7HoqK9PPvAUn5EggXIRke649u86nBJoWlaaVvH3panHrSgh6LnSW4k9Sh505Jq2qpYn2LLSPlPFiatcrip1CL5le2jGZI0VN7fuxPKAo7dwZA3N85IcYxAFXSbz2xinErH0icxNLncqeAEtHsG41ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=beVNyBS33UG2WyOI3llEy12OIYetdLOYsH2jO/35NX9e9hFVfC3x4/P9e+Y9BCKQXbf/TkOF6134zlPq5p6JndIfSX4tTdv1fi9H4+9FXytqVXnG+8c4SiK9JMw2JPnHC5u7j3n1DWTU9xGWc8HQ8fOI6ztxksaU8/amyXcXR6lVrKzZwuGgQArz+fp+qAK0SNCS2fllzJbmPo1ImUbj8rPT7ee6TzRE7GtAxgXnw0jOHGrRPREm09zGGSZb0Mehs1y5VEL6zzwcnN8dvSNMzHPAeApW1/cslzxBLa9Vllozv6g9+AYJXAfTcN1ls4dOFgueUtZ85NCtWo7CNxHAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 146.201.107.145) smtp.rcpttodomain=soundwitness.org smtp.mailfrom=msn.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=msn.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsu.onmicrosoft.com;
 s=selector2-fsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=EIpEA49GT6RHkL2Rgp6zbPmnh7/3T7nnkAOHbrJ3WwI4kfny5YvxAIDaMaW6LJBDISUuImTL4wD9AZxmE0hsmfXw5U1sjlv4vZPGDo2co3u5iahckjIe+d6VzglqN+1FWJaRgFGiqBkU/cQsJV4ksY6pUIubBuJ62wRvNgQMSyU=
Received: from DS7PR03CA0216.namprd03.prod.outlook.com (2603:10b6:5:3ba::11)
 by SJ0P220MB0384.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:3ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 18:29:51 +0000
Received: from DM6NAM04FT043.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::dc) by DS7PR03CA0216.outlook.office365.com
 (2603:10b6:5:3ba::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend
 Transport; Mon, 6 Dec 2021 18:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 146.201.107.145) smtp.mailfrom=msn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=msn.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 msn.com discourages use of 146.201.107.145 as permitted sender)
Received: from mailrelay03.its.fsu.edu (146.201.107.145) by
 DM6NAM04FT043.mail.protection.outlook.com (10.13.158.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 18:29:51 +0000
Received: from [10.0.0.200] (ani.stat.fsu.edu [128.186.4.119])
        by mailrelay03.its.fsu.edu (Postfix) with ESMTP id 35C3E962F8;
        Mon,  6 Dec 2021 13:29:14 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: From Fred!
To:     Recipients <fred128@msn.com>
From:   "Fred Gamba." <fred128@msn.com>
Date:   Mon, 06 Dec 2021 19:28:31 +0100
Reply-To: fred_gamba@yahoo.co.jp
Message-ID: <139cc0b8-5995-4018-ae13-5ae262f98b55@DM6NAM04FT043.eop-NAM04.prod.protection.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c678ecf7-c0ed-4336-288f-08d9b8e66471
X-MS-TrafficTypeDiagnostic: SJ0P220MB0384:EE_
X-Microsoft-Antispam-PRVS: <SJ0P220MB0384EB4096B6074E8C7E7CB1EB6D9@SJ0P220MB0384.NAMP220.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:146.201.107.145;CTRY:US;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:mailrelay03.its.fsu.edu;PTR:mailrelay03.its.fsu.edu;CAT:OSPM;SFS:(4636009)(84050400002)(46966006)(40470700001)(6862004)(47076005)(82202003)(6666004)(2860700004)(6200100001)(31696002)(83380400001)(508600001)(7406005)(6266002)(316002)(786003)(7416002)(7366002)(8676002)(82310400004)(956004)(70206006)(86362001)(3480700007)(7116003)(5660300002)(40460700001)(26005)(31686004)(2906002)(7596003)(336012)(35950700001)(8936002)(356005)(9686003)(70586007)(480584002);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVJDZDJmeElSTGR1cWo0U0tNQXlya2NMajdsem8vK2JvYkxBalh3OG15QmlS?=
 =?utf-8?B?Ym5abEpYMjBmSzRFdmQvM2xaME4xa0k0YjY2LzBISkhyUUVsSzRrR0dMcnZS?=
 =?utf-8?B?a3ZZanRkcWlYRlZLVlQrUnZQMnd2TllTUlhkU1RmTEQ5VFhvUDExN0xFQWdG?=
 =?utf-8?B?MG9Ja25nN0Z2eXpaKzV0aTlSSEpERWRObzhmb0lIMDhmZmlDU2xoM0pXYy9R?=
 =?utf-8?B?cE9jMjdFZVhOK1libTNJRWtWRmEwY2FtTXJaczlQSG5CTHdlZEpOczZuVnBz?=
 =?utf-8?B?cTA1T0dUMTdjdm9xUUVWdEVQMDlLbGZmT1RLUVRsekkzaVBoM3dQQy9oQXRG?=
 =?utf-8?B?UlBNRTBhVHpjWngwQ21KbWhxUzZzVlVUOTJzTWVjdmJpNjNTa2dML1cvM0xj?=
 =?utf-8?B?cVpibXBlUWVKVnpYUFFHM21jeER2bG80R1hjWTdjQ1lNd0pGWXJQWGVSMWVw?=
 =?utf-8?B?WkpYcldSUmcxUzg5YUh2bkkrdkJLeWIrM1d4MWFRL2xmQTRkc2J5ODZoRU9F?=
 =?utf-8?B?bXE3Y3NVUFdWb1ZzSzBka0tLQ1kvNG9xb2pzVCtoNGRMTGZtR3NQQzkvOXZ4?=
 =?utf-8?B?ZVZja2ltVEcwbmNjL3JHK28vdU5CVGJVWXVpeEUwMVBBRjRFRTgzcGZHK2dq?=
 =?utf-8?B?TTdwWXNDTVRqTzNNQldhNHlPMlZmY1ZacWxaRXlNY3NXYjRZWkR6WFZ0MWdn?=
 =?utf-8?B?OFd3V1dsRkVNUzdQbERGZWEwZnhKZVZMQVI1VWNUa1A5bDBackxzU3k4Tndo?=
 =?utf-8?B?SG1CZG1tOEQxSjhETkhWNENXZWlQNWFlYzZMckthUFVnaHVUaGo0Nk5GZnBq?=
 =?utf-8?B?cDdOWUN5ZXdtY0xPRkVYOXgyYmgwS0tDR2IzRHVOMUdCZFhycGNocGlWcTR5?=
 =?utf-8?B?MGxhR1d1SmcxV20xOCt4d3pqOXREWk9aT3dCL3RySmNzWWRQT3JJQno4NVAz?=
 =?utf-8?B?OFZiRko2Y2FMZTN1UzhqbjVvMUtrc3RhallWVGFvQjdiUmI1OWFnU2dSZGFz?=
 =?utf-8?B?OGdkZlJab0VTMXFQZXA3UXhQV2c3czRWSFk0OXU5ZVc1ZGRYSkI2Q2lKZ05U?=
 =?utf-8?B?d0NsR3d0V0lMS1h1dkM5MzR4dkVLQXMvS0JhM2lORDVRaFJkcVhaTmFvNHZN?=
 =?utf-8?B?QUtOTDdST2VsVm53d2VxeDJzL1cwTnZNK1B1YmtSR1dBZjdOVVUxS2NRTXZR?=
 =?utf-8?B?TnV2RE83cHFocDhOWkNUYzF2RG84MjVodUtndmRiUml6MDVGRkF3NS9jSDdF?=
 =?utf-8?B?aFYrK0Z5RFZibEp0ZW1JenlkL1lLNURlV05hdjAvam4zKzd4TnB4KzFFZTlt?=
 =?utf-8?B?VW5uYnRkVUZHWnhKODVQb0o1KzVsV2w2TG8ya2pvaVd1cTU0VkJ3cVVPejRo?=
 =?utf-8?B?ZXovOTBOaTYzc2xyQ0ExSDljWnA2VmMvTmpKWHA1dU9JU1JhZkpTSTkxQzB0?=
 =?utf-8?Q?dhGew0Hf?=
X-OriginatorOrg: fsu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 18:29:51.5356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c678ecf7-c0ed-4336-288f-08d9b8e66471
X-MS-Exchange-CrossTenant-Id: a36450eb-db06-42a7-8d1b-026719f701e3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a36450eb-db06-42a7-8d1b-026719f701e3;Ip=[146.201.107.145];Helo=[mailrelay03.its.fsu.edu]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT043.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0384
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello,

I decided to write you this proposal in good faith, believing that you will=
 not betray me. I have been in search of someone with the same last name of=
 our late customer and close friend of mine (Mr. Richard), heence I contact=
ed you Because both of you bear the same surname and coincidentally from th=
e same country, and I was pushed to contact you and see how best we can ass=
ist each other. Meanwhile I am Mr. Fred Gamba, a reputable banker here in A=
ccra Ghana.

On the 15 January 2009, the young millionaire (Mr. Richard) a citizen of yo=
ur country and Crude Oil dealer made a fixed deposit with my bank for 60 ca=
lendar months, valued at US $ 6,500,000.00 (Six Million, Five Hundred Thous=
and US Dollars) and The mature date for this deposit contract was on 15th o=
f January, 2015. But sadly he was among the death victims in the 03 March 2=
011, Earthquake disaster in Japan that killed over 20,000 people including =
him. Because he was in Japan on a business trip and that was how he met his=
 end.

My bank management is yet to know about his death, but I knew about it beca=
use he was my friend and I am his Account Relationship Officer, and he did =
not mention any Next of Kin / Heir when the account was opened, because he =
was not married and no children. Last week my Bank Management reminded me a=
gain requested that Mr. Richard should give instructions on what to do abou=
t his funds, if to renew the contract or not.

I know this will happen and that is why I have been looking for a means to =
handle the situation, because if my Bank Directors happens to know that he =
is dead and do not have any Heir, they will take the funds for their person=
al use, That is why I am seeking your co-operation to present you as the Ne=
xt of Kin / Heir to the account, since you bear same last name with the dec=
eased customer.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law okay. So It's =
better that we claim the money, than allowing the Bank Directors to take it=
, they are rich already. I am not a greedy person, so I am suggesting we sh=
are the funds in this ratio, 50% 50, ie equal.

Let me know your mind on this and please do treat this information highly c=
onfidential.

I will review further information to you as soon as I receive your
positive response.

Have a nice day and I anticipating your communication.

With Regards,
Fred Gamba.
