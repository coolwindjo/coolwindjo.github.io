---
layout: post
title: European Automotive Market Overview - KES 2025
categories: Trends
status: published
tags:
  - claude-sonnet45
  - research-mode
---
2025-11-20 00:19

Tags: [[business]], [[automotive-trends]]

# European Automotive Market Overview - KES 2025
## Comprehensive Analysis for Asian Automotive Software Companies

**Based on presentations from:**
- BMW Group (Hyun Jung-jo)
- Infineon Technologies (Hans Adlkofer)
- ZVEI (Clemens Otte)
- Bayern Innovativ (Dr. Malte Kohring)
- STMicroelectronics and others

**Event:** Korea-Europe Semiconductor Summit 2025, Munich, Germany
**Date:** November 18, 2025

---

## Executive Summary

The European automotive market is undergoing a fundamental transformation driven by electrification, software-defined vehicles, and geopolitical pressures. European OEMs and Tier 1 suppliers are restructuring their supply chains through "directed buy" models, seeking greater control over semiconductor sourcing and software development. This creates significant opportunities for Asian automotive software companies, particularly Korean suppliers, who currently represent only 4% of BMW's €91.8 billion purchasing volume.

**Key Market Indicators:**
- European EV adoption: 17.4% in 2024, targeting 25-30% by 2027-2028
- Electrified vehicles (including PHEVs): Already 25% of sales
- 800V architecture becoming standard for fast charging
- Zonal architecture replacing distributed ECU systems
- Software-defined vehicles enabling hardware-software decoupling

---

## 1. AUTOMOTIVE SOFTWARE TRENDS

### 1.1 Software-Defined Vehicle Architecture

**BMW's New Architecture Strategy:**

BMW is transitioning to a "Neue Klasse" platform with four "super brain" layers:
1. **Core Brain** - Central computing power
2. **Panoramic iDrive** - User interface and digital cockpit experience
3. **Autonomous Driving** - Self-driving capabilities
4. **Heart of Joy** - Driving dynamics and emotional connection

**Key Technical Evolution:**
- **From:** Distributed ECU architecture (100+ ECUs per vehicle)
- **To:** Zonal architecture with centralized computing
- **Middleware layer** supporting: OTA updates, cybersecurity, AI platform, data management

**Critical Insight for Asian SW Companies:**
> "Zonal architecture with centralized computing power is the key for self-driving vehicles and an innovation driver for the semiconductor industry." - BMW

### 1.2 IVI System Evolution

**Current Generation (2023-2025):**
- Linux-based NGU22 systems: Wi-Fi 6, 250 Mbit/s
- Android-based IDC23/IDC Evo: Wi-Fi 6E (6 GHz band), 800 Mbit/s

**Next Generation (SOP 2030):**
- Must predict technology requirements until 2040
- Focus on resilience and long-term premium positioning
- 98% of BMW customers connect smartphones - seamless integration critical

**Digital Ecosystem Components:**
- Entertainment systems for passengers and drivers
- Multiple touchscreens with personalization
- Head-up displays
- Health check functions
- Consumer electronics device compatibility

### 1.3 Connectivity Architecture

**Two-ECU Approach:**
- **Head Unit:** In-cabin connectivity (entertainment, smartphone integration)
- **Telematics:** External connectivity (cloud services, V2X infrastructure)

**Technology Roadmap:**
- Wi-Fi 6E already in production (IDC Evo)
- Planning for Wi-Fi 7 and beyond for 2030 SOP
- Bluetooth, 5G modems, GPS integration
- Premium device concepts (wearables, health monitors, game controllers)

---

## 2. SEMICONDUCTOR DIRECTED BUY MODEL

### 2.1 Paradigm Shift in Supply Chain

**Traditional Model Problems:**
- High software development costs (not reusable)
- Quality issues not under OEM control
- Long reaction time for defect management through Tier 1
- Lack of transparency with semiconductor suppliers
- Semiconductor shortage vulnerabilities (COVID-19 crisis)

**New Directed Buy Model:**

```
┌─────────┐    Direct Collaboration    ┌──────────────┐
│   BMW   │ ←────────────────────────→ │ Semiconductor│
│   OEM   │    Direct Contracts        │  Suppliers   │
└────┬────┘                             └──────────────┘
     │                                          │
     │        System Integration               │
     │              & ECU                       │
     └──────────→ Tier 1 ←─────────────────────┘
```

**Key Benefits:**
1. **Direct technical collaboration** with semiconductor suppliers
2. **Software ownership** transferred from Tier 1 to BMW
3. **Direct influence** on chipset design and future roadmaps
4. **Faster reaction time** for defect management
5. **Cost savings** through software reusability
6. **Supply chain resilience** through direct relationships

**Critical Success Factor:**
> "Three-party collaboration (OEM-Semiconductor-Tier1) is the key for successful implementation" - BMW

### 2.2 Software Stack Responsibility Changes

**Wireless Service Platform Example:**

| Layer | Previous (Tier 1) | Future (Directed Buy) |
|-------|-------------------|----------------------|
| Application | BMW | BMW |
| Middleware | Tier 1 | **BMW In-house** |
| Drivers | Tier 1 | **BMW In-house** |
| Hardware Abstraction | Tier 1 | **BMW In-house** |
| Physical Layer | Tier 1/Tier 2 | **Direct Semiconductor** |

**Note:** Tier 1 still provides complete ECU and overall Android system integration

### 2.3 Opportunities for Korean Suppliers

**Current State:**
- Korean suppliers: **4% of BMW's €91.8B purchasing volume**
- Korea is BMW's **5th largest market globally (3.5%)**
- Korea is **3rd largest market** for 5/7 Series segments (after China, USA)
- BMW actively seeking to increase Korean supplier partnerships

**Target Areas:**
1. Wireless connectivity modules (Wi-Fi, Bluetooth, 5G)
2. Software development (middleware, drivers, HAL)
3. Semiconductor design collaboration
4. System integration services

---

## 3. SEMICONDUCTOR TECHNOLOGY TRENDS

### 3.1 Power Semiconductor Evolution

**Infineon's Three-Technology Strategy:**

The automotive industry requires three distinct power semiconductor technologies optimized for different use cases:

#### **Silicon-based IGBT**
- **Applications:** Entry-level EVs, low-cost powertrains
- **Characteristics:** Mature technology, proven reliability
- **Voltage:** 400V systems
- **Frequency:** 1kHz-10kHz
- **Cost:** Lowest per kW
- **Market Position:** Declining but still significant workhorse

#### **Silicon Carbide (SiC)**
- **Applications:** Long-range EVs, highway driving, premium vehicles
- **Characteristics:** Superior efficiency, especially in partial load
- **Voltage:** 400V and **800V systems** (enabling fast charging)
- **Frequency:** 10kHz-300kHz
- **Efficiency:** Optimal for WLTP test cycles and highway "steady sailing"
- **Market Position:** **Becoming dominant technology** - main choice for next 5-10 years
- **Key Advantage:** 10-15% better range through improved partial load efficiency

#### **Gallium Nitride (GaN)**
- **Applications:** Onboard chargers, DC-DC converters, multi-level inverters
- **Characteristics:** Ultra-compact, high switching frequency
- **Frequency:** 100kHz-10MHz  
- **Power Density:** 22kW in "shoebox" form factor
- **Voltage:** 100V-11kV (in multi-level topologies)
- **Market Position:** Emerging, fastest implementation in China
- **Unique Advantage:** Extremely compact design, ideal for space-constrained applications

### 3.2 Five Key Technology Selection Factors

Infineon evaluates power semiconductors based on:

1. **Temperature:** Maximum operating temperature capability
2. **Voltage level:** 400V vs 800V system compatibility
3. **Switching losses:** Efficiency at different operating points
4. **Integration:** Physical size and packaging efficiency
5. **Cost:** System-level cost optimization

> "None of the technologies is best in all classes. We make it dependent on what is your use case." - Infineon

### 3.3 Hybrid Technology Approaches

**Fusion Switch Technology:**
- Combines SiC + IGBT in one module
- Cost-effective solution approaching pure SiC performance
- Balances cost and efficiency

**Multi-level Inverters:**
- 3-level topologies enable GaN advantages at high voltage
- Working with Korean companies on implementation
- China leading in deployment speed

### 3.4 High Voltage System Architecture

**Critical Applications Moving to High Voltage:**
- Traction inverters (50kW-300kW)
- DC-DC converters
- Onboard chargers (11kW-22kW)
- Climate compressors
- HVAC systems
- Chassis applications

**800V Architecture Benefits:**
- **Fast charging:** 10-15 minutes vs 30-60 minutes
- Reduced cable weight and complexity
- Improved system efficiency
- Standard for premium EVs

### 3.5 Market Growth Projections

**Power Semiconductor Market (2023-2030):**
- **Silicon IGBT:** Declining from majority to ~40% market share
- **Silicon Carbide:** Growing to dominant ~50%+ market share
- **GaN:** Steady growth in niche applications (OBC, DC-DC)

**Electrification Forecast:**
- **By 2030:** ~50% of vehicles electrified globally
- Strong growth continues despite recent slowdown
- Diverse powertrain mix (BEV, PHEV, MHEV, REEV, FCEV)

### 3.6 Beyond Automotive: AI Server Market

**Infineon's AI Data Center Focus:**
- Current: 48V systems insufficient for AI power demands
- Transition: Moving to **400V/800V** with SiC
- Power density: 125kW per rack today → **250kW** soon → **1 megawatt by 2028**
- Technology: SiC + GaN combination for voltage conversion
- Challenge: Converting 400-800V down to 0.8V at the chip
- Infineon is **choice supplier** for major AI infrastructure providers

---

## 4. EUROPEAN POLICY LANDSCAPE

### 4.1 European Chips Act Evolution

**Chips Act 1.0 (2023) - Crisis Response:**

**Three Pillars:**
1. **Pillar 1:** Strengthen technological capabilities (pilot lines, design infrastructure, competence centers)
2. **Pillar 2:** Build production capacity (first-of-a-kind projects like TSMC, ESMC)
3. **Pillar 3:** Crisis mechanism and monitoring for supply chain resilience

**Achievements:**
- TSMC Dresden fab construction (despite Intel/Wolfspeed setbacks)
- €43B+ investment commitments
- New partnerships with leading semiconductor companies

**Limitations:**
- 20% global production target **not achievable** under current conditions
- Study shows: Even with Intel/Wolfspeed, Europe would maintain only 8% by 2045
- Without additional investment: Would decline to 6%
- Focus too narrow on front-end fabs
- Fragmented governance across member states

### 4.2 Chips Act 2.0 - Strategic Framework (Early 2026)

**ZVEI's Key Priority Recommendations:**

#### **1. Clearer Governance**
- Problem: Fragmented decisions across member states → long approval cycles
- Solution: Centralized coordination, new dedicated budget for strategic projects
- Goal: Faster decision-making, aligned European strategy

#### **2. Stronger Integration of User Industries**
- Automotive, industrial equipment, energy, healthcare dependencies
- User industries must define technology priorities
- Ensure long-term supply security for critical applications
- Focus on "demand-driven" rather than "supply-driven" strategy

#### **3. Broader "First-of-a-Kind" Definition**
Current: Mainly front-end fabs
Needed: 
- **Advanced packaging** and substrates
- **Consumable materials** and specialty chemicals
- **System integration** capabilities
- **Equipment manufacturing**

#### **4. Much Stronger International Partnerships**
- Recognition: "No country can cover the full supply chain"
- Target: Deeper cooperation with **trusted partners like Korea**
- Areas: Research, talent development, economic security
- Korea explicitly named as strategic partner in German strategy

### 4.3 Germany's National Microelectronics Strategy (September 2025)

**Three Guiding Principles:**
1. Developing strengths
2. Exploring new opportunities
3. Increasing resilience

**Six Strategic Focus Areas:**
1. New chip types and architectures (industrial, automotive, energy, security)
2. Leading-edge capabilities (manufacturing, design, pilot lines, system integration)
3. Stable supply for European user industries
4. Upstream value chain (equipment, materials, specialty chemicals)
5. Strong talent base development
6. Coordinated action across all actors

**International Cooperation:**
> "Korea explicitly included as trusted partner in semiconductor research, talent development, and economic security" - German Ministry

### 4.4 Critical Vulnerabilities

**Printed Circuit Boards (PCBs):**
- Europe's market share: **Only 2.2%**
- China's market share: **60%**
- Security risk: Can embed chips in PCBs
- Strategic assessment: "If we do not act here, we lose strategic control"

**Other Critical Gaps:**
- Advanced packaging capabilities
- Algorithm development
- Electronic manufacturing systems

---

## 5. BAVARIAN ECOSYSTEM OVERVIEW

### 5.1 Bavaria as European Semiconductor Hub

**Economic Powerhouse:**
- 13.3 million inhabitants
- €770 billion GDP
- Largest federal state in Germany
- Leader in German patent registrations

**Key Export Sectors (All semiconductor-dependent):**
- Automotive
- Electronics
- Machinery
- Chemicals

### 5.2 Bavarian Chips Alliance

**Five Pillars of Bavarian Semiconductor Initiative:**
1. **Talents:** Strengthen skilled workforce
2. **Funding Programs:** Bavarian Chip Design Center
3. **Invest in Bavaria:** Settlement support
4. **Bavarian Chips Alliance:** Expert network
5. **Settlement Support:** Infrastructure and ecosystem

**Full Supply Chain Coverage:**
- Suppliers (materials, equipment)
- Designers (Apple, etc.)
- Manufacturing (front-end and back-end)
- Science (universities, research institutions)
- Electronics, PCB, hardware
- Software and product integration
- Application industries (automotive, etc.)

**Major Players in Bavaria:**
- **Infineon:** Headquarters in Munich
- **Apple:** Multi-billion chip design center in Munich
- **OpenAI:** Opened offices in Munich (2025)
- Global companies: BMW, Audi, Siemens, Airbus, Microsoft, Amazon, Google

### 5.3 Three Powerful Ecosystems

**1. Bavarian Chips Alliance**
- Focus: Semiconductor supply chain
- Activities: Chip design, supply chain workshops, AI applications, manufacturing sustainability

**2. Thinknet 6G**
- Focus: Communication technologies
- Structure: Think tank + networking
- Hubs: Munich and Erlangen-Nuremberg
- International partnerships beyond Bavaria

**3. Thinknet Quantum Technology**
- Focus: Future computing technologies
- Complements semiconductor ecosystem

### 5.4 Korea-Bavaria Partnership

**Current Relations:**
- 4,700+ Korean citizens in Bavaria
- 800+ Korean students
- Strong existing partnerships with KOTRA

**Meeting Points:**
- SEMICON Europe 2025 (Munich, this week)
- SEMICON Korea 2026

**Partnership Invitation:**
> "Let's grow together. Bavaria is what we love. Semiconductors are what we know." - Dr. Malte Kohring, Bayern Innovativ

---

## 6. GEOPOLITICAL CHALLENGES

### 6.1 US-China Technology Tensions

**US Sanctions Impact (March 2025):**

**Scope:**
- Affects: Wi-Fi, Bluetooth, 5G modems, GPS, RF signals
- Does NOT affect: Processors, power management, sensors, other semiconductors

**Restricted Sources:**
- Products manufactured in China
- Software implemented in China
- Software developed by Chinese nationals (regardless of location)
- Also applies to: Russia, North Korea, Iran, Cuba

**BMW's Response Strategy:**
1. **Current:** Using wireless chipsets from Western suppliers
2. **Future (SOP 2030):** Preparing "China variant" for vehicles sold in China
3. **Approach:** Building relationships with Chinese local wireless suppliers as backup
4. **Flexibility:** Market-specific configurations based on destination

**Cost Impact:**
> "Overhead and extra development cost without delivering tangible customer benefits. But we must prepare in advance." - BMW

### 6.2 Supply Chain Resilience Requirements

**De-sourcing and Dual-sourcing:**
- No longer optional - now **mandatory**
- Multiple suppliers for critical components
- Geographic diversification
- Technology sovereignty considerations

**Key Lessons from COVID-19:**
- €102 billion GDP impact in Germany alone (automotive + industrial)
- Hidden costs: Bullwhip effects, emergency task forces
- Wake-up call: "Without semiconductors, Europe comes to a standstill"

**Korea-Germany Shared Reality:**
- Both economies rely on complex global supply chains
- Both learned from concentration risks (Korea: materials, Germany: chips)
- Diversification is shared priority
- Goal: Multiple reliable sourcing options, not de-globalization

---

## 7. OPPORTUNITIES FOR ASIAN AUTOMOTIVE SW COMPANIES

### 7.1 Immediate Market Entry Points

**1. Wireless Connectivity Software**
- Middleware development for Wi-Fi 6E/7
- Bluetooth stack implementation
- 5G modem integration software
- GPS/positioning software
- Android automotive platform expertise

**2. Directed Buy Support Services**
- Semiconductor selection consulting
- Software-hardware co-design
- Integration testing services
- Quality assurance for direct supply model
- Supply chain management software

**3. IVI System Development**
- Digital cockpit applications
- Smartphone integration solutions
- Health monitoring software
- Entertainment system development
- Personalization algorithms

**4. Cybersecurity Solutions**
- OTA update security
- Secure boot implementation
- Intrusion detection systems
- Data encryption services
- Compliance with European regulations

### 7.2 Strategic Partnership Models

**Three-Party Collaboration Opportunities:**

```
Korean SW Company Roles:
┌────────────────────────────────────────────────┐
│                                                │
│  1. OEM Direct Partnership                     │
│     - Software development contracts           │
│     - System integration services              │
│     - Long-term platform collaboration         │
│                                                │
│  2. Semiconductor Vendor Partnership           │
│     - Software enablement for chips            │
│     - Reference design development             │
│     - Joint customer support                   │
│                                                │
│  3. Tier 1 Collaboration                       │
│     - ECU software development                 │
│     - Integration services                     │
│     - Testing and validation                   │
│                                                │
└────────────────────────────────────────────────┘
```

### 7.3 Technology Areas with High Demand

**Power Electronics Software:**
- Battery management systems (BMS)
- Inverter control algorithms
- Thermal management software
- Energy optimization algorithms
- 800V system controllers

**Zonal Architecture Software:**
- Zone controller software
- Gateway implementations
- Service-oriented architecture (SOA)
- Middleware for distributed computing
- Real-time operating systems (RTOS)

**AUTOSAR and Middleware:**
- AUTOSAR Classic/Adaptive implementation
- Middleware platform development
- Communication stacks (CAN, Ethernet, etc.)
- Diagnostic services
- Configuration tools

### 7.4 Competitive Advantages for Korean Companies

**1. Technology Leadership:**
- Strong semiconductor ecosystem in Korea
- Advanced memory technologies
- 5G leadership
- Display and HMI expertise

**2. Automotive Heritage:**
- Hyundai/Kia global success
- Tier 1 suppliers (Hyundai Mobis, LG, Samsung)
- Understanding of automotive quality requirements
- Cost-competitive development

**3. Cultural and Business Alignment:**
- German companies value Korean work ethic and precision
- Existing strong bilateral trade relationships
- Geographic proximity to China while maintaining Western partnerships
- Quick decision-making culture

**4. Government Support:**
- Korea-Europe research partnerships (Horizon Europe)
- KOTRA support network
- Government R&D funding programs
- Strategic technology initiatives

### 7.5 Market Entry Barriers and Mitigation

**Barriers:**
1. **Automotive qualification requirements**
   - Mitigation: Partner with established Tier 1, pursue IATF 16949

2. **Language and cultural differences**
   - Mitigation: Hire local team in Germany, use Bavaria offices

3. **Long development cycles (5-10 years)**
   - Mitigation: Focus on software services first, build track record

4. **Established relationships (96% European suppliers)**
   - Mitigation: Leverage directed buy model, offer differentiation

5. **Regulatory compliance (UNECE, EU regulations)**
   - Mitigation: Partner with certification experts, invest in compliance team

### 7.6 Recommended Market Entry Strategy

**Phase 1: Establish Presence (Year 1-2)**
- Open office in Munich/Bavaria area
- Join Bavarian Chips Alliance as partner
- Attend SEMICON Europe, automotive conferences
- Hire local business development team
- Build relationships with KOTRA Munich

**Phase 2: Pilot Projects (Year 2-3)**
- Secure small software development contracts
- Prove capability in non-critical systems
- Build reference customers
- Demonstrate cost and quality competitiveness
- Obtain relevant certifications

**Phase 3: Scale Partnership (Year 3-5)**
- Expand to critical system development
- Multi-year framework agreements
- Joint development programs
- Participate in directed buy programs
- Establish as tier-preferred supplier

---

## 8. KEY TAKEAWAYS AND RECOMMENDATIONS

### 8.1 Critical Market Insights

**1. Software-Defined Vehicles Are Not Optional**
- Every major OEM is transitioning to SDV architecture
- Software reusability is becoming mandatory
- Traditional Tier 1 model is being disrupted
- Opportunity window for new entrants is NOW

**2. Directed Buy Model Creates New Access Points**
- OEMs want direct relationships with capable software providers
- Three-party collaboration is the new normal
- Korean companies have explicit invitation to participate
- Current 4% share of BMW spending shows huge growth potential

**3. Power Semiconductor Software Is Critical**
- Three technologies (IGBT, SiC, GaN) require different software approaches
- 800V systems require new control algorithms
- Efficiency optimization through software is key differentiator
- Server/AI market using same technologies - potential crossover

**4. Geopolitical Factors Create Urgency**
- US-China tensions drive dual-sourcing requirements
- European desire to reduce Asian dependency
- Korea positioned as "trusted partner" by Germany
- Supply chain resilience now strategic priority

**5. European Policy Strongly Supports International Partnership**
- Chips Act 2.0 explicitly prioritizes Korea collaboration
- Government funding available for joint projects
- Horizon Europe now includes Korea
- Strong political will to diversify supply chains

### 8.2 Strategic Recommendations

**For Asian Automotive Software Companies:**

**IMMEDIATE ACTIONS (Next 6 months):**
1. Establish contact with BMW, Infineon, other OEMs through KOTRA
2. Join Bavarian Chips Alliance or similar networks
3. Attend SEMICON Europe 2025 (this week)
4. Assess internal capabilities against European requirements
5. Identify 2-3 target technology areas for focus

**SHORT-TERM (6-18 months):**
1. Open liaison office in Munich/Bavaria region
2. Hire local business development and technical staff
3. Begin certification process (IATF 16949, ISO 26262)
4. Secure pilot project with Tier 1 or OEM
5. Build partnership with European semiconductor vendor

**MEDIUM-TERM (18-36 months):**
1. Expand development capacity in Europe
2. Target directed buy opportunities with major OEMs
3. Develop reference designs for key applications
4. Apply for Horizon Europe funding for joint projects
5. Establish as qualified supplier for 2028-2030 platforms

**LONG-TERM (3-5 years):**
1. Become preferred partner for software-defined vehicle platforms
2. Multi-OEM customer base
3. Participate in next-generation technology development
4. Joint ventures or deeper partnerships with European players
5. Thought leadership in automotive software innovation

### 8.3 Critical Success Factors

**1. Quality and Reliability**
- Automotive quality standards are non-negotiable
- Functional safety (ISO 26262) is mandatory
- Cybersecurity (ISO 21434) increasingly critical
- Testing and validation must be rigorous

**2. Long-term Commitment**
- Automotive relationships take years to build
- Must commit to 10+ year support lifecycle
- Investment required before revenue
- Patient capital essential

**3. Cultural Adaptation**
- German business culture values precision and process
- Documentation and traceability critical
- Direct communication preferred
- Reliability and punctuality essential

**4. Technical Excellence**
- Must demonstrate deep expertise in target areas
- Innovation valued but maturity required
- System understanding as important as coding
- Continuous learning and adaptation necessary

**5. Strategic Positioning**
- Position as "trusted partner" not just supplier
- Emphasize complementary strengths (Korea + Germany)
- Leverage geopolitical positioning carefully
- Build reputation through consistent delivery

---

## 9. CONTACT INFORMATION AND RESOURCES

### Key Organizations for Partnership

**Bavarian Chips Alliance**
Bayern Innovativ GmbH
Dr. Malte Kohring, Head of Digitalization Division
Munich, Germany
(Contact via KOTRA Munich)

**KOTRA Munich Office**
Primary liaison for Korean-German semiconductor partnerships
Supports business development and partnership facilitation

**ZVEI (German Electrical and Electronic Manufacturers' Association)**
Clemens Otte, Director of Microelectronics
Policy and industry coordination

**BMW Group**
Hyun Jung-jo (John), Tech Lead, Wireless Connectivity & Semiconductor Portfolio
Direct contact for connectivity software opportunities

**Infineon Technologies AG**
Hans Adlkofer, SVP Automotive Systems
Power semiconductor and system integration partnerships

### Upcoming Events

**SEMICON Europe 2025**
Location: Munich, Germany
Date: November 2025 (this week)
Focus: Meet European semiconductor ecosystem

**SEMICON Korea 2026**
Focus: Strengthen Korea-Europe partnerships

### Further Research Resources

1. European Chips Act documentation (ec.europa.eu)
2. German Microelectronics Strategy (BMWK)
3. BMW supplier portal and qualification requirements
4. Infineon automotive partner program
5. Horizon Europe Korea partnership program
6. ZVEI position papers on semiconductor policy

---

## CONCLUSION

The European automotive market presents unprecedented opportunities for Asian automotive software companies, particularly those from Korea. The convergence of technological transformation (SDV, electrification), supply chain restructuring (directed buy), and geopolitical factors (trusted partner status) creates a unique window of opportunity.

**The key message from all presentations is clear:** European OEMs and semiconductor companies are actively seeking international partnerships, explicitly naming Korea as a strategic priority. The current 4% Korean supplier share of BMW's €91.8B purchasing volume demonstrates enormous growth potential.

**Success requires:**
- Immediate action to establish presence and relationships
- Long-term commitment to quality and partnership
- Technical excellence in high-demand areas (connectivity, power electronics, SDV)
- Cultural sensitivity and adaptation
- Strategic positioning as complementary partner, not competitor

**The opportunity is real, substantial, and time-sensitive.** European OEMs are making platform decisions NOW for 2028-2030 production. Companies that establish themselves as capable, reliable partners in the next 18-24 months will benefit from multi-year, high-value relationships throughout the next decade.

The door is open. The invitation is explicit. The time to act is now.

---

*Document compiled from presentations at Korea-Europe Semiconductor Summit 2025*  
*For Asian automotive software companies seeking European market opportunities*  
*November 2025*


## References
- https://claude.ai/chat/a71f86b4-761e-4c6d-b3f3-3968ed4cb41b 