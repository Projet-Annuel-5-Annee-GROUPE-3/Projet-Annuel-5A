class Script {
  process_incoming_request({ request }) {
    console.log(request.content);

    let attachments = [];
    let emoji = null;

    request.content.alerts.forEach(alert => {
      let attachment = {
        title: `${alert.labels.alertname} on instance ${alert.labels.instance}`,
        title_link: alert.generatorURL,
        color: "",
        fields: []
      };

      switch (alert.status) {
        case "resolved":
          attachment.color = "good";
          emoji = ":white_check_mark:";
          break;
        case "firing":
          attachment.color = "danger";
          emoji = ":warning:";
          break;
        default:
          attachment.color = "warning";
          emoji = ":warning:";
      }

      attachment.fields.push({ title: "Status", value: `${emoji} ${alert.status}`, short: true });

      if (alert.labels.severity) {
        attachment.fields.push({ title: "Severity", value: alert.labels.severity, short: true });
      }

      attachment.fields.push({ title: "Start time", value: alert.startsAt, short: true });

      if (alert.status === "resolved") {
        attachment.fields.push({ title: "End time", value: alert.endsAt, short: true });
      } else {
        if (alert.annotations.summary) {
          attachment.fields.push({ title: "Summary", value: alert.annotations.summary, short: false });
        }
        if (alert.annotations.description) {
          attachment.fields.push({ title: "Description", value: alert.annotations.description, short: false });
        }
      }

      attachments.push(attachment);
    });

    return {
      content: {
        username: "Prometheus Monitoring",
        attachments: attachments
      }
    };
  }
}
