import Cocoa

enum EventError: Error {
  case eventNotFound
  case participantNotFound
}

protocol EventDelegate {
  func eventDidStart(_ event: Event)
  func eventDidEnd(_ event: Event)
}

struct Participant {
  var name: String
  var email: String
}

class Event {
  var title: String
  var date: Date
  var location: String
  var participant: [Participant]
  var delegate: EventDelegate?

  init(title: String, date: Date, location: String, participant: [Participant], delegate: EventDelegate? = nil) {
    self.title = title
    self.date = date
    self.location = location
    self.participant = participant
    self.delegate = delegate
  }
  
  func eventInfo(){
    "title: \(title), date: \(date), location: \(location), participants: \(participant)"
  }
}

class EventManager: EventDelegate {
  var events: [Event] = []
  func eventDidStart(_ event: Event) {
    print("Event has started")
  }
  
  func eventDidEnd(_ event: Event) {
    print("Event has ended")
  }
  
  func addEvent(_ event: Event){
    events.append(event)
  }
  func removeEvent(_ eventName: String){
    if events.first?.title == eventName {
      events.removeLast()
    }else {
      print("There's no event")
    }
  }
  func findEventByTitle(_ title: String) throws -> Event {
    guard let event = events.first(where: {event in
      event.title == title
    }) else {
      throw EventError.eventNotFound
    }
    return event
  }
  
  func findParticipantByEmail(_ email: String) throws  {
    let participant = Participant
  }
}

extension String {
  func isValidEmail() -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: self)
  }
}

extension Array where Element: Event {
    func filterEvents(byDate date: Date) -> [Element] {
        return self.filter { $0.date == date }
    }
}

let eventManager = EventManager()
eventManager.addEvent(Event(title: "F1", date: .now, location: "Singapore", participant: [Participant(name: "Naufal", email: "naufal@gmail.com")]))

eventManager.eventDidStart(Event(title: "Pesta Rakyat", date: .now, location: "Ancol, Jakarta", participant: [Participant(name: "Faris", email: "faris@gmail.com")]))

eventManager.eventDidEnd(Event(title: "F1", date: .now, location: "Singapore", participant: [Participant(name: "Naufal", email: "naufal@gmail.com")]))


do {
  let findEvent = try eventManager.findEventByTitle("F1")
  print(findEvent.title)
//  let removeEvent = try eventManager.removeEvent("F2")
//  print(removeEvent)
}catch {
  print(error)
}
