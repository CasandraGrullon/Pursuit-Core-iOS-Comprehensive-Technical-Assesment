//
//  CTATests.swift
//  CTATests
//
//  Created by casandra grullon on 3/23/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import XCTest
import Firebase
@testable import CTA

class CTATests: XCTestCase {
    
    func testArtObjectAPI() {
        let firstResult = """
        {
        "elapsedMilliseconds": 0,
        "count": 7075,
        "countFacets": {
            "hasimage": 4294,
            "ondisplay": 42
        },
        "artObjects": [
            {
                "links": {
                    "self": "http://www.rijksmuseum.nl/api/en/collection/BK-2000-17",
                    "web": "http://www.rijksmuseum.nl/en/collection/BK-2000-17"
                },
                "id": "en-BK-2000-17",
                "objectNumber": "BK-2000-17",
                "title": "Self-portrait",
                "hasImage": true,
                "principalOrFirstMaker": "Johan Gregor van der Schardt",
                "longTitle": "Self-portrait, Johan Gregor van der Schardt, c. 1573",
                "showImage": true,
                "permitDownload": true,
                "webImage": {
                    "guid": "30aba21b-6bb6-4079-bc2f-5f8ddc23aa7e",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 2500,
                    "height": 2101,
                    "url": "https://lh6.ggpht.com/xRdPoKg0QHZ2yC_JIrOs3axy7_qHm_OxejFHO3HnseIoQ0fU5Vb5o1clahYSqIgccXpkvCbay2yn8ltN49b8ydIIWNg=s0"
                },
                "headerImage": {
                    "guid": "717fb9f6-daf4-4031-8653-b163f6764137",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 1920,
                    "height": 460,
                    "url": "https://lh4.ggpht.com/E_3F8CLCNl-Mpmj-ra9v9YBpO3MOvmPWwo_9e0YLjBxA5LKv9j8QkL-GKa_oFRw2NPGfl8owGfmzRXMQfUQ3kYbjWFc=s0"
                },
                "productionPlaces": []
            },
            {
                "links": {
                    "self": "http://www.rijksmuseum.nl/api/en/collection/SK-A-3262",
                    "web": "http://www.rijksmuseum.nl/en/collection/SK-A-3262"
                },
                "id": "en-SK-A-3262",
                "objectNumber": "SK-A-3262",
                "title": "Self-portrait",
                "hasImage": true,
                "principalOrFirstMaker": "Vincent van Gogh",
                "longTitle": "Self-portrait, Vincent van Gogh, 1887",
                "showImage": true,
                "permitDownload": true,
                "webImage": {
                    "guid": "b9d83b68-40b3-42cf-8d5e-959201ddf4bf",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 2034,
                    "height": 2562,
                    "url": "https://lh3.googleusercontent.com/Ckjq-HkB2XhEsbuMsei0MR5fLTODfkcXY8qQTG-XLHVxE0jLO9DnSYaVE8n1kCrcm9AMKzoWB2w03LrY0v7eoj5hYw=s0"
                },
                "headerImage": {
                    "guid": "87fe6026-45a1-41d2-a126-9e330eda65a9",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 1920,
                    "height": 460,
                    "url": "https://lh3.googleusercontent.com/R_c2Y-3aFaNIts1RjQbymqwVLGBpibpSg5kq4YqWVtIP6wEG3YYMQX-5kgTfj2ccooBGQz3HQH-xMH_3srmpFiRqbw=s0"
                },
                "productionPlaces": []
            },
            {
                "links": {
                    "self": "http://www.rijksmuseum.nl/api/en/collection/SK-A-4691",
                    "web": "http://www.rijksmuseum.nl/en/collection/SK-A-4691"
                },
                "id": "en-SK-A-4691",
                "objectNumber": "SK-A-4691",
                "title": "Self-portrait",
                "hasImage": true,
                "principalOrFirstMaker": "Rembrandt van Rijn",
                "longTitle": "Self-portrait, Rembrandt van Rijn, c. 1628",
                "showImage": true,
                "permitDownload": true,
                "webImage": {
                    "guid": "89de22aa-e19f-4c83-87ff-26dd8f319c05",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 2118,
                    "height": 2598,
                    "url": "https://lh3.googleusercontent.com/7qzT0pbclLB7y3fdS1GxzMnV7m3gD3gWnhlquhFaJSn6gNOvMmTUAX3wVlTzhMXIs8kM9IH8AsjHNVTs8em3XQI6uMY=s0"
                },
                "headerImage": {
                    "guid": "99061015-b788-42ed-a9d8-06db0bcf39e3",
                    "offsetPercentageX": 0,
                    "offsetPercentageY": 0,
                    "width": 1920,
                    "height": 460,
                    "url": "https://lh3.googleusercontent.com/WKIxue0nAIOYj00nGVoO4DTP9rU2na0qat5eoIuQTf6Fbp4mHHm-wbCes1Oo6K_6IdMl6Z_OCjGW_juCCf_jvQqaKw=s0"
                },
                "productionPlaces": []
            }
        }
        """.data(using: .utf8)!
        let exp = XCTestExpectation(description: "BK-2000-17")
        do {
            exp.fulfill()
            let decoder = try JSONDecoder().decode(Collection.self, from: firstResult)
            XCTAssertEqual(decoder.artObjects.first?.objectNumber, exp.description)
        } catch {
            XCTFail("could not convert data \(error.localizedDescription)")
        }
        wait(for: [exp], timeout: 5.0)
    }
    func testEventsAPI() {
        let events = """
{
"_embedded": {
    "events": [
        {
            "name": "Kate Del Castillo - Estoy OKate",
            "type": "event",
            "id": "vv16aZAOSvgZAC7GvG",
            "test": false,
            "url": "https://concerts.livenation.com/kate-del-castillo-estoy-okate-los-angeles-california-04-03-2020/event/09005833075D3B0B",
            "locale": "en-us",
            "images": [
                {
                    "ratio": "16_9",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RETINA_PORTRAIT_16_9.jpg",
                    "width": 640,
                    "height": 360,
                    "fallback": false
                },
                {
                    "ratio": "3_2",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_ARTIST_PAGE_3_2.jpg",
                    "width": 305,
                    "height": 203,
                    "fallback": false
                },
                {
                    "ratio": "4_3",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_CUSTOM.jpg",
                    "width": 305,
                    "height": 225,
                    "fallback": false
                },
                {
                    "ratio": "16_9",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_TABLET_LANDSCAPE_LARGE_16_9.jpg",
                    "width": 2048,
                    "height": 1152,
                    "fallback": false
                },
                {
                    "ratio": "16_9",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RETINA_LANDSCAPE_16_9.jpg",
                    "width": 1136,
                    "height": 639,
                    "fallback": false
                },
                {
                    "ratio": "3_2",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RETINA_PORTRAIT_3_2.jpg",
                    "width": 640,
                    "height": 427,
                    "fallback": false
                },
                {
                    "ratio": "3_2",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_TABLET_LANDSCAPE_3_2.jpg",
                    "width": 1024,
                    "height": 683,
                    "fallback": false
                },
                {
                    "ratio": "16_9",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_TABLET_LANDSCAPE_16_9.jpg",
                    "width": 1024,
                    "height": 576,
                    "fallback": false
                },
                {
                    "ratio": "16_9",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_EVENT_DETAIL_PAGE_16_9.jpg",
                    "width": 205,
                    "height": 115,
                    "fallback": false
                },
                {
                    "ratio": "16_9",
                    "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RECOMENDATION_16_9.jpg",
                    "width": 100,
                    "height": 56,
                    "fallback": false
                }
            ],
            "sales": {
                "public": {
                    "startDateTime": "2020-01-31T18:00:00Z",
                    "startTBD": false,
                    "endDateTime": "2020-04-04T02:00:00Z"
                }
            },
            "dates": {
                "start": {
                    "localDate": "2020-04-03",
                    "localTime": "19:00:00",
                    "dateTime": "2020-04-04T02:00:00Z",
                    "dateTBD": false,
                    "dateTBA": false,
                    "timeTBA": false,
                    "noSpecificTime": false
                },
                "timezone": "America/Los_Angeles",
                "status": {
                    "code": "cancelled"
                },
                "spanMultipleDays": false
            },
            "classifications": [
                {
                    "primary": true,
                    "segment": {
                        "id": "KZFzniwnSyZfZ7v7na",
                        "name": "Arts & Theatre"
                    },
                    "genre": {
                        "id": "KnvZfZ7v7l1",
                        "name": "Theatre"
                    },
                    "subGenre": {
                        "id": "KZazBEonSMnZfZ7v7ll",
                        "name": "Miscellaneous"
                    },
                    "type": {
                        "id": "KZAyXgnZfZ7v7nI",
                        "name": "Undefined"
                    },
                    "subType": {
                        "id": "KZFzBErXgnZfZ7v7lJ",
                        "name": "Undefined"
                    },
                    "family": false
                }
            ],
            "promoter": {
                "id": "653",
                "name": "LIVE NATION MUSIC",
                "description": "LIVE NATION MUSIC / NTL / USA"
            },
            "promoters": [
                {
                    "id": "653",
                    "name": "LIVE NATION MUSIC",
                    "description": "LIVE NATION MUSIC / NTL / USA"
                }
            ],
            "info": "RESERVED ORCHESTRA / LOGE / MEZZANINE",
            "pleaseNote": "This event has been canceled. Refunds at Point of Purchase only. Internet & Phone orders will automatically be canceled & refunded.",
            "priceRanges": [
                {
                    "type": "standard",
                    "currency": "USD",
                    "min": 45.0,
                    "max": 125.0
                }
            ],
            "products": [
                {
                    "id": "vv110ZpdG4afZP",
                    "url": "https://concerts.livenation.com/underground-lounge-pass-kate-del-castillo-los-angeles-california-04-03-2020/event/0900583315254025",
                    "type": "Upsell",
                    "name": "UNDERGROUND LOUNGE PASS: Kate Del Castillo"
                },
                {
                    "id": "vv1k0ZpdG4G7DVvX",
                    "url": "https://concerts.livenation.com/the-wiltern-passenger-pass-los-angeles-california-04-03-2020/event/0900583315EF407E",
                    "type": "Upsell",
                    "name": "The Wiltern - Passenger Pass"
                },
                {
                    "id": "vv1ke8vbGsGA1CVkt",
                    "url": "https://concerts.livenation.com/premium-parking-kate-del-castillo-los-angeles-california-04-03-2020/event/090058331A3B41A9",
                    "type": "Upsell",
                    "name": "PREMIUM PARKING: KATE DEL CASTILLO"
                }
            ],
            "seatmap": {
                "staticUrl": "https://maps.ticketmaster.com/maps/geometry/3/event/09005833075D3B0B/staticImage?type=png&systemId=HOST"
            },
            "ticketLimit": {
                "info": "There is an 8 ticket limit."
            },
            "_links": {
                "self": {
                    "href": "/discovery/v2/events/vv16aZAOSvgZAC7GvG?locale=en-us"
                },
                "attractions": [
                    {
                        "href": "/discovery/v2/attractions/K8vZ917bRe7?locale=en-us"
                    }
                ],
                "venues": [
                    {
                        "href": "/discovery/v2/venues/KovZpZAEAl6A?locale=en-us"
                    }
                ]
            },
            "_embedded": {
                "venues": [
                    {
                        "name": "The Wiltern",
                        "type": "venue",
                        "id": "KovZpZAEAl6A",
                        "test": false,
                        "url": "https://www.ticketmaster.com/the-wiltern-tickets-los-angeles/venue/73790",
                        "locale": "en-us",
                        "images": [
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dbimages/10318v.jpg",
                                "width": 205,
                                "height": 115,
                                "fallback": false
                            }
                        ],
                        "postalCode": "90010",
                        "timezone": "America/Los_Angeles",
                        "city": {
                            "name": "Los Angeles"
                        },
                        "state": {
                            "name": "California",
                            "stateCode": "CA"
                        },
                        "country": {
                            "name": "United States Of America",
                            "countryCode": "US"
                        },
                        "address": {
                            "line1": "3790 Wilshire Blvd."
                        },
                        "location": {
                            "longitude": "-118.30879207",
                            "latitude": "34.06141494"
                        },
                        "markets": [
                            {
                                "name": "Los Angeles",
                                "id": "27"
                            }
                        ],
                        "dmas": [
                            {
                                "id": 223
                            },
                            {
                                "id": 324
                            },
                            {
                                "id": 354
                            },
                            {
                                "id": 383
                            }
                        ],
                        "social": {
                            "twitter": {
                                "handle": "@wiltern"
                            }
                        },
                        "boxOfficeInfo": {
                            "phoneNumberDetail": "24hr Information, (213) 388-1400.",
                            "openHoursDetail": "Box office opens 2 hours before show time for day of ticket sales and future ticket sales. and accepts cash and cc (Visa, MC, Amx, Discover)",
                            "acceptedPaymentDetail": "When purchasing tickets in advance: Box office accepts Visa, MC, AMEX, Discover, or cash",
                            "willCallDetail": "Available 2 hours before performance."
                        },
                        "parkingDetail": "There are several parking lots in the area. The most convenient lot is the Ralph's parking structure located south and east of the theatre on Oxford street. Enter only thru the Northern entrance- not the Ralphs entrance. Parking is generally $20 per car",
                        "accessibleSeatingDetail": "Accessible seating is available online or by calling Ticketmaster 800.745.3000. Disability will be accommodated at the door subject to availability. For additional accessible information, please call 213.388.1400",
                        "generalInfo": {
                            "generalRule": "The Wiltern no longer offers a coat check service. Lockers are available upon request and are offered on a first come first serve basis. Guests are not permitted to bring bottles, cans, weapons, back packs, posters, outside food and beverage items, stickers, cameras with detachable lenses, audio/video recording devices, tripods/monopods, alcohol, drugs and illegal substances, large bags or backpacks inside the venue. Smoking is permitted only on the Smoking Patio located on the south west side of the building. There are no \"in's and out's\" permitted.",
                            "childRule": "No children under 5 will be admitted except for family or children's shows. ** Everyone must have a ticket. **"
                        },
                        "upcomingEvents": {
                            "_total": 46,
                            "ticketmaster": 46
                        },
                        "_links": {
                            "self": {
                                "href": "/discovery/v2/venues/KovZpZAEAl6A?locale=en-us"
                            }
                        }
                    }
                ],
                "attractions": [
                    {
                        "name": "Kate Del Castillo",
                        "type": "attraction",
                        "id": "K8vZ917bRe7",
                        "test": false,
                        "url": "https://concerts.livenation.com/kate-del-castillo-tickets/artist/2722688",
                        "locale": "en-us",
                        "images": [
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RETINA_PORTRAIT_16_9.jpg",
                                "width": 640,
                                "height": 360,
                                "fallback": false
                            },
                            {
                                "ratio": "3_2",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_ARTIST_PAGE_3_2.jpg",
                                "width": 305,
                                "height": 203,
                                "fallback": false
                            },
                            {
                                "ratio": "4_3",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_CUSTOM.jpg",
                                "width": 305,
                                "height": 225,
                                "fallback": false
                            },
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_TABLET_LANDSCAPE_LARGE_16_9.jpg",
                                "width": 2048,
                                "height": 1152,
                                "fallback": false
                            },
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RETINA_LANDSCAPE_16_9.jpg",
                                "width": 1136,
                                "height": 639,
                                "fallback": false
                            },
                            {
                                "ratio": "3_2",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RETINA_PORTRAIT_3_2.jpg",
                                "width": 640,
                                "height": 427,
                                "fallback": false
                            },
                            {
                                "ratio": "3_2",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_TABLET_LANDSCAPE_3_2.jpg",
                                "width": 1024,
                                "height": 683,
                                "fallback": false
                            },
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_TABLET_LANDSCAPE_16_9.jpg",
                                "width": 1024,
                                "height": 576,
                                "fallback": false
                            },
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_EVENT_DETAIL_PAGE_16_9.jpg",
                                "width": 205,
                                "height": 115,
                                "fallback": false
                            },
                            {
                                "ratio": "16_9",
                                "url": "https://s1.ticketm.net/dam/a/a0c/5f198742-12a5-41f6-a4d8-c6a960d3ea0c_1312311_RECOMENDATION_16_9.jpg",
                                "width": 100,
                                "height": 56,
                                "fallback": false
                            }
                        ],
                        "classifications": [
                            {
                                "primary": true,
                                "segment": {
                                    "id": "KZFzniwnSyZfZ7v7na",
                                    "name": "Arts & Theatre"
                                },
                                "genre": {
                                    "id": "KnvZfZ7v7l1",
                                    "name": "Theatre"
                                },
                                "subGenre": {
                                    "id": "KZazBEonSMnZfZ7v7ll",
                                    "name": "Miscellaneous"
                                },
                                "type": {
                                    "id": "KZAyXgnZfZ7v7la",
                                    "name": "Individual"
                                },
                                "subType": {
                                    "id": "KZFzBErXgnZfZ7vAdl",
                                    "name": "Actor"
                                },
                                "family": false
                            }
                        ],
                        "upcomingEvents": {
                            "_total": 5,
                            "tmr": 1,
                            "ticketmaster": 4
                        },
                        "_links": {
                            "self": {
                                "href": "/discovery/v2/attractions/K8vZ917bRe7?locale=en-us"
                            }
                        }
                    }
                ]
            }
        }
}
""".data(using: .utf8)!
        let exp = XCTestExpectation(description: "Kate Del Castillo - Estoy OKate")
        do {
            exp.fulfill()
            let decoder = try JSONDecoder().decode(TicketMaster.self, from: events)
            XCTAssertEqual(decoder.embedded?.events.first?.name, exp.description)
        } catch {
            XCTFail("could not decode data \(error.localizedDescription)")
        }
        wait(for: [exp], timeout: 5.0)
    }
    
}

